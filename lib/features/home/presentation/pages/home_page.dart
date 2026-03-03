import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/section_header.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/memory_verse_card.dart';
import '../widgets/quick_player_card.dart';
import '../widgets/seminar_carousel_section.dart';
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
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeError) {
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
                      context.read<HomeCubit>().loadHomeData();
                    },
                    child: const Text('Дахин оролдох'),
                  ),
                ],
              ),
            );
          }

          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: AppTheme.spacingXLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seminars carousel
                    if (state.seminars.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppTheme.spacingMedium,
                          bottom: AppTheme.spacingSmall,
                        ),
                        child: SeminarCarouselSection(
                          seminars: state.seminars,
                          onTap: (seminar) {
                            context.push('/events/${seminar.id}');
                          },
                        ),
                      ),
                    // Weekly program section
                    const SectionHeader(
                      title: 'Долоо хоногийн хөтөлбөр',
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    WeeklyProgramSection(
                      program: state.weeklyProgram,
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),
                    // Memory verse card
                    SectionHeader(
                      title: 'Эшлэл цээжлэх',
                      actionText: 'Бүгдийг харах',
                      actionIcon: Icons.arrow_forward_ios,
                      onActionTap: () {
                        context.go('/library');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                      ),
                      child: MemoryVerseCard(
                        verse: state.memoryVerse,
                        onTap: () {
                          // TODO: Navigate to verse detail
                        },
                        onShare: () {
                          // TODO: Share verse
                        },
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),
                    // Quick player card
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
