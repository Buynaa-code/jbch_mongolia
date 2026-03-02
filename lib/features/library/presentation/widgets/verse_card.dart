import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/verse_model.dart';
import '../../../../shared/widgets/app_card.dart';

/// Card displaying a Bible verse
class VerseCard extends StatelessWidget {
  final VerseModel verse;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onShare;

  const VerseCard({
    super.key,
    required this.verse,
    this.onTap,
    this.onFavoriteToggle,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with reference and actions
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingXSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_stories,
                      size: 14,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      verse.reference,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (verse.isMemoryVerse)
                Padding(
                  padding: const EdgeInsets.only(left: AppTheme.spacingSmall),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSmall,
                      vertical: AppTheme.spacingXSmall,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: Text(
                      'Цээжлэх',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  verse.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: verse.isFavorite
                      ? AppColors.error
                      : theme.colorScheme.onSurfaceVariant,
                ),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(AppTheme.spacingXSmall),
              ),
              IconButton(
                onPressed: onShare,
                icon: Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(AppTheme.spacingXSmall),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          // Verse text
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSmall),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceContainerHighDark
                  : AppColors.tertiary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Text(
              '"${verse.text}"',
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
