import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// A reusable audio player widget with play/pause, progress, and skip controls
class AudioPlayerWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final Duration currentPosition;
  final Duration totalDuration;
  final bool isPlaying;
  final VoidCallback? onPlayPause;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<double>? onSeek;
  final bool showSkipButtons;
  final bool compact;

  const AudioPlayerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    required this.currentPosition,
    required this.totalDuration,
    required this.isPlaying,
    this.onPlayPause,
    this.onPrevious,
    this.onNext,
    this.onSeek,
    this.showSkipButtons = true,
    this.compact = false,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (compact) {
      return _buildCompactPlayer(context, theme, isDark);
    }

    return _buildFullPlayer(context, theme, isDark);
  }

  Widget _buildCompactPlayer(
      BuildContext context, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingSmall),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceContainerDark
            : AppColors.surfaceContainerLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          // Album art
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (_, _, _) => Icon(
                        Icons.music_note,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  )
                : Icon(
                    Icons.music_note,
                    color: theme.colorScheme.primary,
                  ),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Play/Pause button
          IconButton(
            onPressed: onPlayPause,
            icon: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullPlayer(BuildContext context, ThemeData theme, bool isDark) {
    final progress = totalDuration.inMilliseconds > 0
        ? currentPosition.inMilliseconds / totalDuration.inMilliseconds
        : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Album art
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (_, _, _) => Icon(
                      Icons.music_note,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
              : Icon(
                  Icons.music_note,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        // Title and subtitle
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppTheme.spacingXSmall),
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        // Progress bar
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: theme.colorScheme.primary,
                  inactiveTrackColor:
                      theme.colorScheme.primary.withValues(alpha: 0.2),
                  thumbColor: theme.colorScheme.primary,
                  overlayColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: Slider(
                  value: progress.clamp(0.0, 1.0),
                  onChanged: onSeek,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppTheme.spacingSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(currentPosition),
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      _formatDuration(totalDuration),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacingMedium),
        // Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showSkipButtons)
              IconButton(
                onPressed: onPrevious,
                icon: const Icon(Icons.skip_previous_rounded),
                iconSize: 40,
                color: theme.colorScheme.onSurface,
              ),
            const SizedBox(width: AppTheme.spacingMedium),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: onPlayPause,
                icon: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                ),
                iconSize: 40,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMedium),
            if (showSkipButtons)
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.skip_next_rounded),
                iconSize: 40,
                color: theme.colorScheme.onSurface,
              ),
          ],
        ),
      ],
    );
  }
}
