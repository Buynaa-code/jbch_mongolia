import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/event_model.dart';
import '../../../../shared/widgets/app_card.dart';

/// Card displaying the next upcoming seminar
class NextSeminarCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;

  const NextSeminarCard({
    super.key,
    required this.event,
    this.onTap,
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

  String _getTimeUntil(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} өдрийн дараа';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} цагийн дараа';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} минутын дараа';
    } else {
      return 'Одоо';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppGradientCard(
      onTap: onTap,
      gradientColors: [
        AppColors.primary,
        AppColors.primaryLight,
      ],
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingXSmall,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.event,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: AppTheme.spacingXSmall),
                    Text(
                      'Дараагийн семинар',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingXSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  _getTimeUntil(event.dateTime),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          // Title
          Text(
            event.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          // Description
          Text(
            event.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          // Date and location
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(width: AppTheme.spacingXSmall),
              Text(
                _formatDate(event.dateTime),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXSmall),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(width: AppTheme.spacingXSmall),
              Expanded(
                child: Text(
                  event.location,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
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
}
