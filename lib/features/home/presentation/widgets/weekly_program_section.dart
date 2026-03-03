import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/weekly_program.dart';

/// Section displaying the weekly church program
class WeeklyProgramSection extends StatelessWidget {
  final List<WeeklyProgramItem> program;

  const WeeklyProgramSection({
    super.key,
    required this.program,
  });

  int _getCurrentDayIndex() {
    final now = DateTime.now();
    // Sunday = 7 in DateTime, but we want it as 0
    return now.weekday == 7 ? 0 : now.weekday;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentDayIndex = _getCurrentDayIndex();

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
        itemCount: program.length,
        itemBuilder: (context, index) {
          final item = program[index];
          final isToday = index == currentDayIndex;

          return Padding(
            padding: EdgeInsets.only(
              right: index < program.length - 1 ? AppTheme.spacingSmall : 0,
            ),
            child: _DayCard(
              item: item,
              isToday: isToday,
              isDark: isDark,
            ),
          );
        },
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final WeeklyProgramItem item;
  final bool isToday;
  final bool isDark;

  const _DayCard({
    required this.item,
    required this.isToday,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 120,
      padding: const EdgeInsets.all(AppTheme.spacingSmall),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.primary
            : (isDark
                ? AppColors.surfaceContainerDark
                : AppColors.surfaceContainerLight),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: isToday
            ? null
            : Border.all(
                color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day name
          Text(
            item.dayName,
            style: theme.textTheme.titleSmall?.copyWith(
              color: isToday ? Colors.white : theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isToday)
            Container(
              margin: const EdgeInsets.only(top: AppTheme.spacingXSmall),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Өнөөдөр',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          const Spacer(),
          // Events
          ...item.events.take(2).map((event) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingXSmall),
                child: Row(
                  children: [
                    Text(
                      event.icon,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.time,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isToday
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : theme.colorScheme.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            event.title,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isToday
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
