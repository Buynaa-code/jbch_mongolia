import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/announcement.dart';

/// A carousel that displays special announcements
class AnnouncementCarouselSection extends StatefulWidget {
  final List<Announcement> announcements;
  final void Function(Announcement)? onTap;

  const AnnouncementCarouselSection({
    super.key,
    required this.announcements,
    this.onTap,
  });

  @override
  State<AnnouncementCarouselSection> createState() =>
      _AnnouncementCarouselSectionState();
}

class _AnnouncementCarouselSectionState
    extends State<AnnouncementCarouselSection> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _autoPlayTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    if (widget.announcements.length <= 1) return;

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _isUserInteracting) return;
      final nextPage = (_currentPage + 1) % widget.announcements.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _pauseAutoPlay() {
    setState(() => _isUserInteracting = true);
    _autoPlayTimer?.cancel();
  }

  void _resumeAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isUserInteracting = false);
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.announcements.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        GestureDetector(
          onPanDown: (_) => _pauseAutoPlay(),
          onPanEnd: (_) => _resumeAutoPlay(),
          onTapDown: (_) => _pauseAutoPlay(),
          onTapUp: (_) => _resumeAutoPlay(),
          child: SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.announcements.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _pauseAutoPlay();
                _resumeAutoPlay();
              },
              itemBuilder: (context, index) {
                final announcement = widget.announcements[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMedium,
                  ),
                  child: _AnnouncementCard(
                    announcement: announcement,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _pauseAutoPlay();
                      widget.onTap?.call(announcement);
                    },
                  ),
                );
              },
            ),
          ),
        ),

        // Dot indicators
        if (widget.announcements.length > 1) ...[
          const SizedBox(height: AppTheme.spacingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.announcements.length,
              (index) => GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  _pauseAutoPlay();
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                  );
                  _resumeAutoPlay();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Individual announcement card
class _AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;

  const _AnnouncementCard({
    required this.announcement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          decoration: BoxDecoration(
            color: _getBackgroundColor(isDark),
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            border: Border.all(
              color: _getBorderColor(isDark),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Priority indicator
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getPriorityColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  _getPriorityIcon(),
                  color: _getPriorityColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMedium),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Priority badge + Title
                    Row(
                      children: [
                        if (announcement.priority != AnnouncementPriority.normal)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getPriorityLabel(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            announcement.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Text(
                      announcement.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Action button
                    if (announcement.hasAction) ...[
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: onTap,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            minimumSize: const Size(44, 36),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                announcement.actionLabel!,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(bool isDark) {
    if (announcement.priority == AnnouncementPriority.urgent) {
      return isDark
          ? AppColors.error.withValues(alpha: 0.1)
          : AppColors.error.withValues(alpha: 0.05);
    }
    if (announcement.priority == AnnouncementPriority.important) {
      return isDark
          ? AppColors.accent.withValues(alpha: 0.1)
          : AppColors.accent.withValues(alpha: 0.05);
    }
    return isDark ? AppColors.surfaceContainerDark : AppColors.surfaceLight;
  }

  Color _getBorderColor(bool isDark) {
    if (announcement.priority == AnnouncementPriority.urgent) {
      return AppColors.error.withValues(alpha: 0.3);
    }
    if (announcement.priority == AnnouncementPriority.important) {
      return AppColors.accent.withValues(alpha: 0.3);
    }
    return isDark ? AppColors.outlineDark : AppColors.outlineLight;
  }

  Color _getPriorityColor() {
    switch (announcement.priority) {
      case AnnouncementPriority.urgent:
        return AppColors.error;
      case AnnouncementPriority.important:
        return AppColors.accent;
      case AnnouncementPriority.normal:
        return AppColors.primary;
    }
  }

  IconData _getPriorityIcon() {
    switch (announcement.priority) {
      case AnnouncementPriority.urgent:
        return Icons.warning_rounded;
      case AnnouncementPriority.important:
        return Icons.star_rounded;
      case AnnouncementPriority.normal:
        return Icons.campaign_rounded;
    }
  }

  String _getPriorityLabel() {
    switch (announcement.priority) {
      case AnnouncementPriority.urgent:
        return 'ЯАРАЛТАЙ';
      case AnnouncementPriority.important:
        return 'ЧУХАЛ';
      case AnnouncementPriority.normal:
        return '';
    }
  }
}
