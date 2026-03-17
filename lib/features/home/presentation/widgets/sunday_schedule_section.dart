import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/sunday_schedule.dart';

/// Ням гаргийн үйлчлэлийн хуваарь харуулах section
class SundayScheduleSection extends StatefulWidget {
  final SundaySchedule? currentSchedule;
  final SundaySchedule? nextSchedule;

  const SundayScheduleSection({
    super.key,
    this.currentSchedule,
    this.nextSchedule,
  });

  @override
  State<SundayScheduleSection> createState() => _SundayScheduleSectionState();
}

class _SundayScheduleSectionState extends State<SundayScheduleSection> {
  bool _showingCurrentWeek = true;

  SundaySchedule? get _activeSchedule =>
      _showingCurrentWeek ? widget.currentSchedule : widget.nextSchedule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (widget.currentSchedule == null && widget.nextSchedule == null) {
      return _buildEmptyState(theme);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab buttons
          _buildTabButtons(theme, isDark),
          const SizedBox(height: AppTheme.spacingMedium),

          // Schedule card
          if (_activeSchedule != null)
            _SundayScheduleCard(
              schedule: _activeSchedule!,
              isDark: isDark,
            )
          else
            _buildNoScheduleState(theme),
        ],
      ),
    );
  }

  Widget _buildTabButtons(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceContainerDark
            : AppColors.surfaceContainerLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'Энэ 7 хоног',
              isSelected: _showingCurrentWeek,
              onTap: () => setState(() => _showingCurrentWeek = true),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'Дараа 7 хоног',
              isSelected: !_showingCurrentWeek,
              onTap: () => setState(() => _showingCurrentWeek = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Text(
              'Хуваарь оруулаагүй байна',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoScheduleState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Center(
        child: Text(
          _showingCurrentWeek
              ? 'Энэ долоо хоногийн хуваарь байхгүй'
              : 'Дараа долоо хоногийн хуваарь байхгүй',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMedium,
          vertical: AppTheme.spacingSmall + 2,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceLight.withValues(alpha: 0),
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall + 2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _SundayScheduleCard extends StatelessWidget {
  final SundaySchedule schedule;
  final bool isDark;

  const _SundayScheduleCard({
    required this.schedule,
    required this.isDark,
  });

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with date
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMedium),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSmall + 4,
                    vertical: AppTheme.spacingXSmall + 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.onPrimary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_formatDate(schedule.date)} Ням',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.church_outlined,
                  color: AppColors.onPrimary.withValues(alpha: 0.7),
                  size: 28,
                ),
              ],
            ),
          ),

          // Sermon info
          _buildSection(
            context,
            icon: Icons.mic_outlined,
            title: 'Үг',
            content: '${schedule.sermon.speaker} ${schedule.sermon.title}',
          ),

          // Branches
          if (schedule.branches.isNotEmpty)
            _buildBranchesSection(context, schedule.branches),

          // Gathering
          _buildSection(
            context,
            icon: Icons.groups_outlined,
            title: 'Цуглаан',
            content: schedule.gathering.name,
          ),

          // Team
          _buildSection(
            context,
            icon: Icons.flag_outlined,
            title: 'Баг',
            content: '${schedule.team.name} - ${schedule.team.leader}',
          ),

          // Sunday School
          _buildSundaySchoolSection(context, schedule.sundaySchool),

          const SizedBox(height: AppTheme.spacingSmall),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.onPrimary.withValues(alpha: 0.8),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.onPrimary,
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

  Widget _buildBranchesSection(BuildContext context, List<BranchInfo> branches) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 18,
            color: AppColors.onPrimary.withValues(alpha: 0.8),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Салбарууд',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                ...branches.map(
                  (branch) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      '${branch.name}: ${branch.speaker}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSundaySchoolSection(
    BuildContext context,
    SundaySchoolInfo sundaySchool,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMedium,
        vertical: AppTheme.spacingSmall,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.school_outlined,
            size: 18,
            color: AppColors.onPrimary.withValues(alpha: 0.8),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ч/Сур',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildTeacherChip(context, 'Бэлтгэл', sundaySchool.preparation),
                    const SizedBox(width: 8),
                    _buildTeacherChip(context, 'Бага', sundaySchool.junior),
                    const SizedBox(width: 8),
                    _buildTeacherChip(context, 'Д.Ахлах', sundaySchool.senior),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherChip(
    BuildContext context,
    String label,
    TeacherInfo teacher,
  ) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.onPrimary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.onPrimary.withValues(alpha: 0.7),
                fontSize: 9,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              teacher.displayName,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
