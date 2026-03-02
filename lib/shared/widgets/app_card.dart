import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// A reusable card widget with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveBackgroundColor = backgroundColor ??
        (isDark ? AppColors.surfaceContainerDark : AppColors.surfaceLight);

    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppTheme.radiusLarge);

    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        border: border,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: (elevation ?? AppTheme.elevationMedium) * 2,
            offset: Offset(0, elevation ?? AppTheme.elevationMedium),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: Material(
          color: Colors.transparent,
          child: onTap != null
              ? InkWell(
                  onTap: onTap,
                  borderRadius: effectiveBorderRadius,
                  child: Padding(
                    padding: padding ??
                        const EdgeInsets.all(AppTheme.spacingMedium),
                    child: child,
                  ),
                )
              : Padding(
                  padding:
                      padding ?? const EdgeInsets.all(AppTheme.spacingMedium),
                  child: child,
                ),
        ),
      ),
    );

    return card;
  }
}

/// A gradient variant of AppCard for featured content
class AppGradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  const AppGradientCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColors = gradientColors ??
        [
          AppColors.primary,
          AppColors.primaryLight,
        ];

    final borderRadius = BorderRadius.circular(AppTheme.radiusLarge);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: effectiveColors,
          begin: gradientBegin,
          end: gradientEnd,
        ),
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: effectiveColors.first.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: onTap != null
              ? InkWell(
                  onTap: onTap,
                  borderRadius: borderRadius,
                  child: Padding(
                    padding: padding ??
                        const EdgeInsets.all(AppTheme.spacingMedium),
                    child: child,
                  ),
                )
              : Padding(
                  padding:
                      padding ?? const EdgeInsets.all(AppTheme.spacingMedium),
                  child: child,
                ),
        ),
      ),
    );
  }
}
