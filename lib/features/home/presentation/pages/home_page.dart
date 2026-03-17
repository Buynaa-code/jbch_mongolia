import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/section_header.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/announcement_carousel_section.dart';
import '../widgets/memory_verse_card.dart';
import '../widgets/quick_player_card.dart';
import '../widgets/seminar_carousel_section.dart';
import '../widgets/sunday_schedule_section.dart';
import '../widgets/weekly_program_section.dart';

/// Home page displaying church overview
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..loadHomeData(),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JBCH Mongolia',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement notifications
            },
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Мэдэгдэл',
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const _LoadingSkeleton();
          }

          if (state is HomeError) {
            return _ErrorState(
              message: state.message,
              onRetry: () => context.read<HomeCubit>().loadHomeData(),
            );
          }

          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: AppTheme.spacingMedium,
                  bottom: AppTheme.spacingXLarge * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Announcements carousel - онцгой зарлал
                    if (state.announcements.isNotEmpty) ...[
                      const SectionHeader(
                        title: 'Онцгой зарлал',
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      AnnouncementCarouselSection(
                        announcements: state.announcements,
                        onTap: (announcement) {
                          if (announcement.actionUrl != null) {
                            context.push(announcement.actionUrl!);
                          }
                        },
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                    ],

                    // Sunday schedule section - энэ долоо хоногийн хуваарь
                    if (state.currentSundaySchedule != null ||
                        state.nextSundaySchedule != null) ...[
                      const SectionHeader(
                        title: 'Ням гаргийн үйлчлэл',
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      SundayScheduleSection(
                        currentSchedule: state.currentSundaySchedule,
                        nextSchedule: state.nextSundaySchedule,
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                    ],

                    // Seminars carousel with header
                    if (state.seminars.isNotEmpty) ...[
                      const SectionHeader(
                        title: 'Удахгүй болох семинарууд',
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      SeminarCarouselSection(
                        seminars: state.seminars,
                        onTap: (seminar) {
                          context.push('/events/${seminar.id}');
                        },
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                    ],

                    // Weekly program section
                    if (state.weeklyProgram.isNotEmpty) ...[
                      const SectionHeader(
                        title: 'Долоо хоногийн хөтөлбөр',
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      WeeklyProgramSection(
                        program: state.weeklyProgram,
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                    ] else
                      _EmptySection(
                        icon: Icons.event_note_outlined,
                        title: 'Хөтөлбөр одоогоор байхгүй',
                        description: 'Удахгүй энэ долоо хоногийн хөтөлбөр нэмэгдэнэ',
                      ),

                    // Memory verse card - only show if verse is available
                    if (state.memoryVerse != null) ...[
                      SectionHeader(
                        title: 'Эшлэл цээжлэх',
                        actionText: 'Бүгдийг харах',
                        actionIcon: Icons.arrow_forward_ios,
                        onActionTap: () {
                          context.go('/library');
                        },
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMedium,
                        ),
                        child: MemoryVerseCard(
                          verse: state.memoryVerse!,
                          onTap: () {
                            // TODO: Navigate to verse detail
                          },
                          onShare: () {
                            // TODO: Share verse
                          },
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                    ],

                    // Quick player card or music empty state
                    if (state.currentSong != null || state.recentSongs.isNotEmpty) ...[
                      const SectionHeader(
                        title: 'Хөгжим',
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMedium,
                        ),
                        child: QuickPlayerCard(
                          currentSong: state.currentSong,
                          recentSongs: state.recentSongs,
                          isPlaying: state.isPlaying,
                          currentPosition: state.currentPosition,
                          onPlayPause: () {
                            context.read<HomeCubit>().togglePlayPause();
                          },
                          onSongSelect: (song) {
                            context.read<HomeCubit>().setCurrentSong(song);
                          },
                          onViewAll: () {
                            context.go('/library');
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// Skeleton loading state with content placeholders
class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shimmerColor = isDark
        ? AppColors.onSurfaceDark.withValues(alpha: 0.1)
        : AppColors.onSurfaceLight.withValues(alpha: 0.06);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel skeleton
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),

          // Section header skeleton
          Container(
            width: 200,
            height: 24,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),

          // Weekly program skeleton
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                width: 120,
                margin: EdgeInsets.only(
                  right: index < 4 ? AppTheme.spacingSmall : 0,
                ),
                decoration: BoxDecoration(
                  color: shimmerColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),

          // Card skeleton
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: shimmerColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            ),
          ),
        ],
      ),
    );
  }
}

/// Enhanced error state with clear visual hierarchy
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon with accent background
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Error title
            Text(
              'Алдаа гарлаа',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSmall),

            // Error message
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Primary retry button with proper sizing
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Дахин оролдох'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacingMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty section placeholder with clear guidance
class _EmptySection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _EmptySection({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingLarge,
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
