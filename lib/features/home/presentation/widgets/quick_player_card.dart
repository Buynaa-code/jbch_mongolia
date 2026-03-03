import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../library/domain/entities/song.dart';

/// Card displaying a quick music player
class QuickPlayerCard extends StatelessWidget {
  final Song? currentSong;
  final List<Song> recentSongs;
  final bool isPlaying;
  final Duration currentPosition;
  final VoidCallback? onPlayPause;
  final ValueChanged<Song>? onSongSelect;
  final VoidCallback? onViewAll;

  const QuickPlayerCard({
    super.key,
    this.currentSong,
    required this.recentSongs,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
    this.onPlayPause,
    this.onSongSelect,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingSmall),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.headphones,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: AppTheme.spacingSmall),
              Text(
                'Хурдан тоглуулагч',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onViewAll,
                child: const Text('Бүгдийг харах'),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          // Current song player
          if (currentSong != null)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSmall),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceContainerHighDark
                    : AppColors.surfaceContainerHighLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Row(
                children: [
                  // Album art placeholder
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primaryLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSmall),
                  // Song info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong!.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentSong!.artist,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Progress bar
                        LinearProgressIndicator(
                          value: currentSong!.duration.inMilliseconds > 0
                              ? currentPosition.inMilliseconds /
                                  currentSong!.duration.inMilliseconds
                              : 0,
                          backgroundColor:
                              theme.colorScheme.primary.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.primary,
                          ),
                          minHeight: 3,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSmall),
                  // Play/Pause button
                  IconButton(
                    onPressed: onPlayPause,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppTheme.spacingMedium),
          // Recent songs
          Text(
            'Сүүлд тоглуулсан',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          ...recentSongs.take(3).map((song) => _RecentSongTile(
                song: song,
                onTap: () => onSongSelect?.call(song),
                isDark: isDark,
              )),
        ],
      ),
    );
  }
}

class _RecentSongTile extends StatelessWidget {
  final Song song;
  final VoidCallback? onTap;
  final bool isDark;

  const _RecentSongTile({
    required this.song,
    this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingSmall,
        ),
        child: Row(
          children: [
            // Album art placeholder
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceContainerHighDark
                    : AppColors.surfaceContainerHighLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                Icons.music_note,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            // Song info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    song.artist,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Duration
            Text(
              song.formattedDuration,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
