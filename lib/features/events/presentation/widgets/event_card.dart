import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/event_model.dart';
import '../../../../shared/widgets/app_card.dart';

/// Card displaying an event
class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;
  final bool isCompact;

  const EventCard({
    super.key,
    required this.event,
    this.onTap,
    this.isCompact = false,
  });

  String _formatDate(DateTime date) {
    final months = [
      '1-р сар',
      '2-р сар',
      '3-р сар',
      '4-р сар',
      '5-р сар',
      '6-р сар',
      '7-р сар',
      '8-р сар',
      '9-р сар',
      '10-р сар',
      '11-р сар',
      '12-р сар',
    ];
    final weekDays = [
      'Даваа',
      'Мягмар',
      'Лхагва',
      'Пүрэв',
      'Баасан',
      'Бямба',
      'Ням',
    ];

    final weekDay = weekDays[date.weekday - 1];
    final month = months[date.month - 1];
    final time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return '$weekDay, ${date.day} $month, $time';
  }

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
          // Header with type badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingXSmall,
                ),
                decoration: BoxDecoration(
                  color: _getTypeColor(event.type).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.type.emoji,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.type.displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _getTypeColor(event.type),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (event.isUpcoming)
                Icon(
                  Icons.upcoming,
                  size: 16,
                  color: AppColors.secondary,
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          // Title
          Text(
            event.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (!isCompact) ...[
            const SizedBox(height: AppTheme.spacingSmall),
            // Description
            Text(
              event.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: AppTheme.spacingMedium),
          // Date and location
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: isDark
                    ? AppColors.onSurfaceVariantDark
                    : AppColors.onSurfaceVariantLight,
              ),
              const SizedBox(width: AppTheme.spacingXSmall),
              Expanded(
                child: Text(
                  _formatDate(event.dateTime),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXSmall),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: isDark
                    ? AppColors.onSurfaceVariantDark
                    : AppColors.onSurfaceVariantLight,
              ),
              const SizedBox(width: AppTheme.spacingXSmall),
              Expanded(
                child: Text(
                  event.location,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(EventType type) {
    switch (type) {
      case EventType.seminar:
        return AppColors.primary;
      case EventType.worship:
        return AppColors.accent;
      case EventType.youthGroup:
        return AppColors.secondary;
      case EventType.bibleStudy:
        return AppColors.primaryLight;
      case EventType.prayer:
        return AppColors.accent;
      case EventType.fellowship:
        return AppColors.secondary;
      case EventType.special:
        return AppColors.primary;
    }
  }
}
