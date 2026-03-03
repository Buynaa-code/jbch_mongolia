import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/event.dart';
import '../cubit/events_cubit.dart';
import '../cubit/events_state.dart';

/// Event detail page showing full event information
class EventDetailPage extends StatelessWidget {
  final String eventId;

  const EventDetailPage({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EventsCubit>()..loadEvents(),
      child: _EventDetailContent(eventId: eventId),
    );
  }
}

class _EventDetailContent extends StatelessWidget {
  final String eventId;

  const _EventDetailContent({required this.eventId});

  String _formatDate(DateTime date) {
    final months = [
      'нэгдүгээр сар',
      'хоёрдугаар сар',
      'гуравдугаар сар',
      'дөрөвдүгээр сар',
      'тавдугаар сар',
      'зургадугаар сар',
      'долдугаар сар',
      'наймдугаар сар',
      'есдүгээр сар',
      'аравдугаар сар',
      'арван нэгдүгээр сар',
      'арван хоёрдугаар сар',
    ];
    final weekDays = [
      'Даваа',
      'Мягмар',
      'Лхагва',
      'Пүрэв',
      'Баасан',
      'Бямба',
      'Ням',
    ];

    final weekDay = weekDays[date.weekday - 1];
    final month = months[date.month - 1];
    final time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return '$weekDay, ${date.year} оны ${date.day} $month, $time';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is EventsError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(state.message),
                ],
              ),
            ),
          );
        }

        if (state is EventsLoaded) {
          // Find event in loaded events
          Event? event;
          try {
            event = state.upcomingEvents.firstWhere((e) => e.id == eventId);
          } catch (_) {
            try {
              event = state.pastEvents.firstWhere((e) => e.id == eventId);
            } catch (_) {
              event = null;
            }
          }

          if (event == null) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
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
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                // App Bar with image
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryLight,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              event.type.emoji,
                              style: const TextStyle(fontSize: 48),
                            ),
                            const SizedBox(height: AppTheme.spacingSmall),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.spacingSmall,
                                vertical: AppTheme.spacingXSmall,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radiusSmall),
                              ),
                              child: Text(
                                event.type.displayName,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          event.title,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingLarge),
                        // Date and time card
                        _DetailCard(
                          isDark: isDark,
                          icon: Icons.access_time,
                          iconColor: AppColors.accent,
                          title: 'Огноо, цаг',
                          content: _formatDate(event.dateTime),
                        ),
                        const SizedBox(height: AppTheme.spacingSmall),
                        // Location card
                        _DetailCard(
                          isDark: isDark,
                          icon: Icons.location_on,
                          iconColor: AppColors.secondary,
                          title: 'Байршил',
                          content: event.location,
                          trailing: IconButton(
                            onPressed: () {
                              // TODO: Open map
                            },
                            icon: const Icon(Icons.map_outlined),
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingLarge),
                        // Description
                        Text(
                          'Тайлбар',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingSmall),
                        Text(
                          event.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingXLarge),
                        // Status indicator
                        if (event.isUpcoming)
                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.all(AppTheme.spacingMedium),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusMedium),
                              border: Border.all(
                                color:
                                    AppColors.secondary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.upcoming,
                                  color: AppColors.secondary,
                                ),
                                const SizedBox(width: AppTheme.spacingSmall),
                                Expanded(
                                  child: Text(
                                    'Энэ арга хэмжээ удахгүй болно',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.secondaryDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.all(AppTheme.spacingMedium),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHigh,
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusMedium),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppTheme.spacingSmall),
                                Expanded(
                                  child: Text(
                                    'Энэ арга хэмжээ өнгөрсөн',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color:
                                          theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: AppTheme.spacingXLarge),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom action bar
            bottomNavigationBar: event.isUpcoming
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // TODO: Share event
                              },
                              icon: const Icon(Icons.share_outlined),
                              label: const Text('Хуваалцах'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppTheme.spacingMedium,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingSmall),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<EventsCubit>()
                                    .registerForEvent(event!.id);
                              },
                              icon: Icon(
                                event.isRegistered
                                    ? Icons.check
                                    : Icons.calendar_today,
                              ),
                              label: Text(
                                event.isRegistered
                                    ? 'Бүртгэгдсэн'
                                    : 'Бүртгүүлэх',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: event.isRegistered
                                    ? AppColors.secondary
                                    : theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppTheme.spacingMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _DetailCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String content;
  final Widget? trailing;

  const _DetailCard({
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.content,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceContainerDark
            : AppColors.surfaceContainerLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSmall),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
