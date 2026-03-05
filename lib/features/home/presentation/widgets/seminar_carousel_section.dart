import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../events/domain/entities/event.dart';
import 'next_seminar_card.dart';

/// A carousel that cycles through multiple seminar cards
class SeminarCarouselSection extends StatefulWidget {
  final List<Event> seminars;
  final void Function(Event)? onTap;

  const SeminarCarouselSection({
    super.key,
    required this.seminars,
    this.onTap,
  });

  @override
  State<SeminarCarouselSection> createState() => _SeminarCarouselSectionState();
}

class _SeminarCarouselSectionState extends State<SeminarCarouselSection> {
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
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _isUserInteracting) return;
      final nextPage = (_currentPage + 1) % widget.seminars.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
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
    if (widget.seminars.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        GestureDetector(
          onPanDown: (_) => _pauseAutoPlay(),
          onPanEnd: (_) => _resumeAutoPlay(),
          onTapDown: (_) => _pauseAutoPlay(),
          onTapUp: (_) => _resumeAutoPlay(),
          child: SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.seminars.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _pauseAutoPlay();
                _resumeAutoPlay();
              },
              itemBuilder: (context, index) {
                final seminar = widget.seminars[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMedium,
                  ),
                  child: NextSeminarCard(
                    event: seminar,
                    onTap: () {
                      _pauseAutoPlay();
                      widget.onTap?.call(seminar);
                    },
                  ),
                );
              },
            ),
          ),
        ),

        // Dot indicators with better visual design
        if (widget.seminars.length > 1) ...[
          const SizedBox(height: AppTheme.spacingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Page counter for accessibility
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  '${_currentPage + 1} / ${widget.seminars.length}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingSmall),
              // Dot indicators
              ...List.generate(
                widget.seminars.length,
                (index) => GestureDetector(
                  onTap: () {
                    _pauseAutoPlay();
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                    );
                    _resumeAutoPlay();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
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
            ],
          ),
        ],
      ],
    );
  }
}
