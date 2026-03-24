import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/song.dart';

/// Card displaying a song
class SongCard extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final bool isCurrentSong;
  final VoidCallback? onTap;
  final VoidCallback? onPlayPause;
  final VoidCallback? onFavoriteToggle;

  const SongCard({
    super.key,
    required this.song,
    this.isPlaying = false,
    this.isCurrentSong = false,
    this.onTap,
    this.onPlayPause,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingSmall),
        decoration: BoxDecoration(
          color: isCurrentSong
              ? AppColors.primary.withValues(alpha: 0.1)
              : (isDark
                  ? AppColors.surfaceContainerDark
                  : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: isCurrentSong
              ? Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                )
              : null,
        ),
        child: Row(
          children: [
            // Album art / Play indicator
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(song.category),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Icon(
                    Icons.music_note,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
                if (isCurrentSong && isPlaying)
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.shadowDark,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: Icon(
                      Icons.equalizer,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            // Song info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isCurrentSong
                          ? AppColors.primary
                          : theme.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    song.artist,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(song.category)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          song.category.displayName,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getCategoryColor(song.category),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingSmall),
                      Text(
                        song.formattedDuration,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Favorite and play buttons
            IconButton(
              onPressed: onFavoriteToggle,
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              icon: Icon(
                song.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 24,
                color: song.isFavorite
                    ? AppColors.error
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            IconButton(
              onPressed: song.isPlayable ? onPlayPause : null,
              tooltip: song.isPlayable ? null : 'Аудио файл байхгүй',
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              icon: Icon(
                isCurrentSong && isPlaying
                    ? Icons.pause_circle_filled
                    : (song.isPlayable
                        ? Icons.play_circle_filled
                        : Icons.play_disabled),
                size: 44,
                color: song.isPlayable
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(SongCategory category) {
    switch (category) {
      case SongCategory.praise:
        return AppColors.accent;
      case SongCategory.hymn:
        return AppColors.primaryLight;
      case SongCategory.contemporary:
        return AppColors.secondary;
      case SongCategory.children:
        return AppColors.secondaryLight;
    }
  }
}
