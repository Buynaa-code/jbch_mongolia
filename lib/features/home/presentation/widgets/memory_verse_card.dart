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
          : AppColors.tertiary.withValues(alpha: 0.35),
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with better spacing
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingSmall),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.accent.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_stories,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Долоо хоногийн эшлэл',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      verse.reference,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Share button with proper touch target
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onShare,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.share_outlined,
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingLarge),

          // Verse text with enhanced design
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        AppColors.surfaceContainerDark,
                        AppColors.surfaceContainerHighDark,
                      ]
                    : [
                        Colors.white,
                        AppColors.surfaceLight,
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(
                color: isDark
                    ? AppColors.dividerDark
                    : AppColors.accent.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Quote icon at top
                Icon(
                  Icons.format_quote,
                  size: 28,
                  color: AppColors.accent.withValues(alpha: 0.6),
                ),
                const SizedBox(height: AppTheme.spacingMedium),

                // Verse text - larger, more readable
                Text(
                  verse.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingMedium),

                // Divider
                Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSmall),

                // Reference at bottom
                Text(
                  verse.reference,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
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
