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

    if (program.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMedium,
          vertical: AppTheme.spacingLarge,
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 48,
                color:
                    theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppTheme.spacingSmall),
              Text(
                'Хөтөлбөр одоогоор байхгүй',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 165,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
        clipBehavior: Clip.none,
        itemCount: program.length,
        itemBuilder: (context, index) {
          final item = program[index];
          final isToday = index == currentDayIndex;

          return Padding(
            padding: EdgeInsets.only(
              right: index < program.length - 1 ? AppTheme.spacingMedium : 0,
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
      width: 128,
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        gradient: isToday
            ? LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isToday
            ? null
            : (isDark
                ? AppColors.surfaceContainerDark
                : AppColors.surfaceContainerLight),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: isToday
            ? null
            : Border.all(
                color: isDark
                    ? AppColors.dividerDark
                    : AppColors.dividerLight.withValues(alpha: 0.5),
                width: 1.5,
              ),
        boxShadow: isToday
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : (isDark
                ? null
                : [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day name with badge
          Row(
            children: [
              Expanded(
                child: Text(
                  item.dayName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isToday ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (isToday) ...[
            const SizedBox(height: AppTheme.spacingXSmall),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Text(
                'Өнөөдөр',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppTheme.spacingSmall),

          // Events list - use Expanded to prevent overflow
          Expanded(
            child: item.events.isEmpty
                ? Center(
                    child: Text(
                      'Арга хэмжээ байхгүй',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isToday
                            ? theme.colorScheme.onPrimary.withValues(alpha: 0.6)
                            : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...item.events.take(2).map(
                            (event) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppTheme.spacingXSmall,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon
                                  Text(
                                    event.icon,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isToday ? theme.colorScheme.onPrimary : null,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Time
                                        Text(
                                          event.time,
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: isToday
                                                ? theme.colorScheme.onPrimary.withValues(alpha: 0.85)
                                                : theme.colorScheme.onSurfaceVariant,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // Title
                                        Text(
                                          event.title,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: isToday
                                                ? theme.colorScheme.onPrimary
                                                : theme.colorScheme.onSurface,
                                            fontSize: 10,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      if (item.events.length > 2)
                        Text(
                          '+${item.events.length - 2} бусад',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isToday
                                ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                                : theme.colorScheme.primary,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
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
