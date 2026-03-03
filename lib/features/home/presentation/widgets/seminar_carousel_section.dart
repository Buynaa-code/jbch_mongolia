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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % widget.seminars.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
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
        SizedBox(
          // Fixed height so the PageView doesn't need unbounded height
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.seminars.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final seminar = widget.seminars[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMedium,
                ),
                child: NextSeminarCard(
                  event: seminar,
                  onTap: () => widget.onTap?.call(seminar),
                ),
              );
            },
          ),
        ),
        // Dot indicators
        if (widget.seminars.length > 1) ...[
          const SizedBox(height: AppTheme.spacingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.seminars.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
