import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../domain/entities/event.dart';
import '../cubit/events_cubit.dart';
import '../cubit/events_state.dart';
import '../widgets/event_card.dart';

/// Events page displaying all church events
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EventsCubit>()..loadEvents(),
      child: const _EventsPageContent(),
    );
  }
}

class _EventsPageContent extends StatelessWidget {
  const _EventsPageContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Арга хэмжээ',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is EventsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  ElevatedButton(
                    onPressed: () {
                      context.read<EventsCubit>().loadEvents();
                    },
                    child: const Text('Дахин оролдох'),
                  ),
                ],
              ),
            );
          }

          if (state is EventsLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<EventsCubit>().refresh(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Filter chips
                  SliverToBoxAdapter(
                    child: _FilterChips(
                      selectedFilter: state.selectedFilter,
                      onFilterSelected: (type) {
                        context.read<EventsCubit>().filterByType(type);
                      },
                    ),
                  ),
                  // Upcoming events section
                  if (state.filteredUpcomingEvents.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: SectionHeader(
                        title: 'Удахгүй болох',
                        padding: EdgeInsets.only(
                          left: AppTheme.spacingMedium,
                          right: AppTheme.spacingMedium,
                          top: AppTheme.spacingMedium,
                          bottom: AppTheme.spacingSmall,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final event = state.filteredUpcomingEvents[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppTheme.spacingSmall,
                              ),
                              child: EventCard(
                                event: event,
                                onTap: () {
                                  context.push('/events/${event.id}');
                                },
                              ),
                            );
                          },
                          childCount: state.filteredUpcomingEvents.length,
                        ),
                      ),
                    ),
                  ],
                  // Past events section
                  if (state.filteredPastEvents.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: SectionHeader(
                        title: 'Өнгөрсөн арга хэмжээ',
                        padding: EdgeInsets.only(
                          left: AppTheme.spacingMedium,
                          right: AppTheme.spacingMedium,
                          top: AppTheme.spacingLarge,
                          bottom: AppTheme.spacingSmall,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final event = state.filteredPastEvents[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppTheme.spacingSmall,
                              ),
                              child: Opacity(
                                opacity: 0.7,
                                child: EventCard(
                                  event: event,
                                  isCompact: true,
                                  onTap: () {
                                    context.push('/events/${event.id}');
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: state.filteredPastEvents.length,
                        ),
                      ),
                    ),
                  ],
                  // Empty state
                  if (state.filteredUpcomingEvents.isEmpty &&
                      state.filteredPastEvents.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: AppTheme.spacingMedium),
                            Text(
                              'Арга хэмжээ олдсонгүй',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            if (state.selectedFilter != null) ...[
                              const SizedBox(height: AppTheme.spacingSmall),
                              TextButton(
                                onPressed: () {
                                  context.read<EventsCubit>().clearFilter();
                                },
                                child: const Text('Шүүлтүүр арилгах'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  // Bottom padding
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppTheme.spacingXLarge),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final EventType? selectedFilter;
  final ValueChanged<EventType> onFilterSelected;

  const _FilterChips({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      child: Row(
        children: EventType.values.map((type) {
          final isSelected = selectedFilter == type;

          return Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacingSmall),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(type.emoji),
                  const SizedBox(width: 4),
                  Text(type.displayName),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => onFilterSelected(type),
              backgroundColor:
                  isDark ? AppColors.surfaceContainerDark : AppColors.surfaceContainerLight,
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              checkmarkColor: AppColors.primary,
              labelStyle: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : theme.colorScheme.onSurface,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              ),
              side: BorderSide(
                color: isSelected
                    ? AppColors.primary
                    : (isDark ? AppColors.dividerDark : AppColors.dividerLight),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
