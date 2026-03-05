import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/library_cubit.dart';
import '../cubit/library_state.dart';
import '../widgets/sermon_card.dart';
import '../widgets/song_card.dart';
import '../widgets/verse_card.dart';

/// Library page with tabs for verses, songs, and sermons
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LibraryCubit>()..loadLibrary(),
      child: const _LibraryPageContent(),
    );
  }
}

class _LibraryPageContent extends StatefulWidget {
  const _LibraryPageContent();

  @override
  State<_LibraryPageContent> createState() => _LibraryPageContentState();
}

class _LibraryPageContentState extends State<_LibraryPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final tab = LibraryTab.values[_tabController.index];
      context.read<LibraryCubit>().changeTab(tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Номын сан',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Эшлэл', icon: Icon(Icons.auto_stories, size: 20)),
            Tab(text: 'Дуу', icon: Icon(Icons.music_note, size: 20)),
            Tab(text: 'Номлол', icon: Icon(Icons.mic, size: 20)),
          ],
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LibraryError) {
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
                      context.read<LibraryCubit>().loadLibrary();
                    },
                    child: const Text('Дахин оролдох'),
                  ),
                ],
              ),
            );
          }

          if (state is LibraryLoaded) {
            return Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMedium),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      context.read<LibraryCubit>().search(value);
                    },
                    decoration: InputDecoration(
                      hintText: _getSearchHint(state.currentTab),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<LibraryCubit>().search('');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                // Tab content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _VersesTab(
                        verses: state.filteredVerses,
                        onFavoriteToggle: (id) {
                          context.read<LibraryCubit>().toggleVerseFavorite(id);
                        },
                      ),
                      _SongsTab(
                        songs: state.filteredSongs,
                        currentlyPlayingSong: state.currentlyPlayingSong,
                        isPlaying: state.isPlaying,
                        onPlayPause: (song) {
                          if (state.currentlyPlayingSong?.id == song.id) {
                            context.read<LibraryCubit>().togglePlayPause();
                          } else {
                            context.read<LibraryCubit>().playSong(song);
                          }
                        },
                        onSongTap: (song) {
                          context.push('/library/song/${song.id}', extra: song);
                        },
                        onFavoriteToggle: (id) {
                          context.read<LibraryCubit>().toggleSongFavorite(id);
                        },
                      ),
                      _SermonsTab(
                        sermons: state.filteredSermons,
                        onPlay: (sermon) {
                          // TODO: Play sermon
                        },
                        onFavoriteToggle: (id) {
                          context
                              .read<LibraryCubit>()
                              .toggleSermonFavorite(id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _getSearchHint(LibraryTab tab) {
    switch (tab) {
      case LibraryTab.verses:
        return 'Эшлэл хайх...';
      case LibraryTab.songs:
        return 'Дуу хайх...';
      case LibraryTab.sermons:
        return 'Номлол хайх...';
    }
  }
}

class _VersesTab extends StatelessWidget {
  final List verses;
  final ValueChanged<String> onFavoriteToggle;

  const _VersesTab({
    required this.verses,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (verses.isEmpty) {
      return _EmptyState(
        icon: Icons.auto_stories_outlined,
        message: 'Эшлэл олдсонгүй',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      itemCount: verses.length,
      itemBuilder: (context, index) {
        final verse = verses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
          child: VerseCard(
            verse: verse,
            onFavoriteToggle: () => onFavoriteToggle(verse.id),
            onShare: () {
              // TODO: Share verse
            },
          ),
        );
      },
    );
  }
}

class _SongsTab extends StatelessWidget {
  final List songs;
  final dynamic currentlyPlayingSong;
  final bool isPlaying;
  final ValueChanged onPlayPause;
  final ValueChanged onSongTap;
  final ValueChanged<String> onFavoriteToggle;

  const _SongsTab({
    required this.songs,
    this.currentlyPlayingSong,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onSongTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return _EmptyState(
        icon: Icons.music_off_outlined,
        message: 'Дуу олдсонгүй',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        final isCurrentSong = currentlyPlayingSong?.id == song.id;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
          child: SongCard(
            song: song,
            isPlaying: isPlaying,
            isCurrentSong: isCurrentSong,
            onTap: () => onSongTap(song),
            onPlayPause: () => onPlayPause(song),
            onFavoriteToggle: () => onFavoriteToggle(song.id),
          ),
        );
      },
    );
  }
}

class _SermonsTab extends StatelessWidget {
  final List sermons;
  final ValueChanged onPlay;
  final ValueChanged<String> onFavoriteToggle;

  const _SermonsTab({
    required this.sermons,
    required this.onPlay,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (sermons.isEmpty) {
      return _EmptyState(
        icon: Icons.mic_off_outlined,
        message: 'Номлол олдсонгүй',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      itemCount: sermons.length,
      itemBuilder: (context, index) {
        final sermon = sermons[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
          child: SermonCard(
            sermon: sermon,
            onPlay: () => onPlay(sermon),
            onFavoriteToggle: () => onFavoriteToggle(sermon.id),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _EmptyState({
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          Text(
            message,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
