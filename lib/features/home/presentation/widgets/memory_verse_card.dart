import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../library/domain/entities/verse.dart';

/// Card displaying the memory verse of the week
class MemoryVerseCard extends StatelessWidget {
  final Verse verse;
  final VoidCallback? onTap;
  final VoidCallback? onShare;

  const MemoryVerseCard({
    super.key,
    required this.verse,
    this.onTap,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      onTap: onTap,
      backgroundColor: isDark
          ? AppColors.surfaceContainerHighDark
          : AppColors.tertiary.withValues(alpha: 0.3),
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
                  color: AppColors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  size: 20,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppTheme.spacingSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Долоо хоногийн эшлэл',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    verse.reference,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: onShare,
                icon: Icon(
                  Icons.share_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Хуваалцах',
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          // Verse text
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMedium),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceContainerDark
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.format_quote,
                  size: 24,
                  color: AppColors.accent,
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Text(
                  verse.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Text(
                  '— ${verse.reference}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
