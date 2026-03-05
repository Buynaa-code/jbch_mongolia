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
    final hasCurrentSong = currentSong != null;
    final hasRecentSongs = recentSongs.isNotEmpty;

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with view all action
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
              Expanded(
                child: Text(
                  'Хөгжим тоглуулагч',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (hasRecentSongs)
                TextButton.icon(
                  onPressed: onViewAll,
                  icon: const Icon(Icons.library_music, size: 18),
                  label: const Text('Номын сан'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSmall,
                      vertical: AppTheme.spacingXSmall,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMedium),

          // Current song player - prominent when playing
          if (hasCurrentSong)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          AppColors.surfaceContainerHighDark,
                          AppColors.surfaceContainerDark,
                        ]
                      : [
                          AppColors.primaryLight.withValues(alpha: 0.08),
                          AppColors.surfaceContainerHighLight,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Album art with gradient
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
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMedium),

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
                          ],
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingSmall),

                      // Play/Pause button - large touch target for thumb zone
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onPlayPause,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusLarge),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),

                  // Progress bar with time labels
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: currentSong!.duration.inMilliseconds > 0
                              ? currentPosition.inMilliseconds /
                                  currentSong!.duration.inMilliseconds
                              : 0,
                          backgroundColor:
                              theme.colorScheme.primary.withValues(alpha: 0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.primary,
                          ),
                          minHeight: 4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(currentPosition),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            _formatDuration(currentSong!.duration),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Recent songs section
          if (hasRecentSongs) ...[
            if (hasCurrentSong) const SizedBox(height: AppTheme.spacingMedium),
            Text(
              'Сүүлд тоглуулсан',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            ...recentSongs.take(3).map(
                  (song) => _RecentSongTile(
                    song: song,
                    onTap: () => onSongSelect?.call(song),
                    isDark: isDark,
                  ),
                ),
          ],

          // Empty state when no songs
          if (!hasCurrentSong && !hasRecentSongs)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.spacingLarge,
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.music_note_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(
                      'Хөгжим тоглуулаагүй байна',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    TextButton.icon(
                      onPressed: onViewAll,
                      icon: const Icon(Icons.library_music),
                      label: const Text('Номын сан очих'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacingSmall,
            horizontal: AppTheme.spacingXSmall,
          ),
          child: Row(
            children: [
              // Album art placeholder with gradient
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      isDark
                          ? AppColors.surfaceContainerHighDark
                          : AppColors.primary.withValues(alpha: 0.1),
                      isDark
                          ? AppColors.surfaceContainerDark
                          : AppColors.primaryLight.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Icon(
                  Icons.music_note,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMedium),

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
                    const SizedBox(height: 2),
                    Text(
                      song.artist,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacingSmall),

              // Duration badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  song.formattedDuration,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),

              // Play indicator icon
              const SizedBox(width: AppTheme.spacingSmall),
              Icon(
                Icons.play_arrow,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
