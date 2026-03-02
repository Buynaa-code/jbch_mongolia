import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/song_model.dart';
import '../../data/mock_library_data.dart';

/// Full-screen song player page
class SongPlayerPage extends StatefulWidget {
  final String songId;

  const SongPlayerPage({
    super.key,
    required this.songId,
  });

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  late SongModel? _song;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  bool _showLyrics = false;

  @override
  void initState() {
    super.initState();
    _song = MockLibraryData.getSongById(widget.songId);
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seek(double value) {
    if (_song == null) return;
    setState(() {
      _currentPosition = Duration(
        milliseconds: (value * _song!.duration.inMilliseconds).round(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_song == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_off,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppTheme.spacingMedium),
              Text(
                'Дуу олдсонгүй',
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppColors.primary.withValues(alpha: 0.3),
                    AppColors.backgroundDark,
                  ]
                : [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.backgroundLight,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                    ),
                    const Spacer(),
                    Text(
                      'Одоо тоглож байна',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // TODO: More options
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              // Player content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Album art
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryLight,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXLarge),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.music_note,
                          size: 120,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXLarge),
                      // Song info
                      Text(
                        _song!.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      Text(
                        _song!.artist,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppTheme.spacingXSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSmall,
                          vertical: AppTheme.spacingXSmall,
                        ),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusSmall),
                        ),
                        child: Text(
                          _song!.category.displayName,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Progress bar
                      Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 14),
                              activeTrackColor: theme.colorScheme.primary,
                              inactiveTrackColor: theme.colorScheme.primary
                                  .withValues(alpha: 0.2),
                              thumbColor: theme.colorScheme.primary,
                              overlayColor: theme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                            ),
                            child: Slider(
                              value: (_currentPosition.inMilliseconds /
                                      _song!.duration.inMilliseconds)
                                  .clamp(0.0, 1.0),
                              onChanged: _seek,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingMedium,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(_currentPosition),
                                  style: theme.textTheme.bodySmall,
                                ),
                                Text(
                                  _formatDuration(_song!.duration),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                      // Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.shuffle),
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppTheme.spacingMedium),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_previous_rounded),
                            iconSize: 40,
                          ),
                          const SizedBox(width: AppTheme.spacingMedium),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: _togglePlayPause,
                              icon: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                              ),
                              iconSize: 48,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMedium),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_next_rounded),
                            iconSize: 40,
                          ),
                          const SizedBox(width: AppTheme.spacingMedium),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.repeat),
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                      // Bottom actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _ActionButton(
                            icon: Icons.favorite_border,
                            label: 'Дуртай',
                            onPressed: () {},
                          ),
                          _ActionButton(
                            icon: Icons.lyrics_outlined,
                            label: 'Үг',
                            onPressed: () {
                              setState(() {
                                _showLyrics = !_showLyrics;
                              });
                            },
                            isActive: _showLyrics,
                          ),
                          _ActionButton(
                            icon: Icons.share_outlined,
                            label: 'Хуваалцах',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Lyrics panel (if visible)
              if (_showLyrics && _song!.lyrics != null)
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: const EdgeInsets.all(AppTheme.spacingMedium),
                  padding: const EdgeInsets.all(AppTheme.spacingMedium),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceContainerDark
                        : AppColors.surfaceContainerLight,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _song!.lyrics!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor:
            isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
