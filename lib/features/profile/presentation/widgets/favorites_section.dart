import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';

/// Section displaying user's favorite items
class FavoritesSection extends StatelessWidget {
  final List<Verse> favoriteVerses;
  final List<Song> favoriteSongs;
  final VoidCallback? onViewAllVerses;
  final VoidCallback? onViewAllSongs;

  const FavoritesSection({
    super.key,
    required this.favoriteVerses,
    required this.favoriteSongs,
    this.onViewAllVerses,
    this.onViewAllSongs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Favorite verses
        if (favoriteVerses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.auto_stories,
            iconColor: AppColors.accent,
            title: 'Дуртай эшлэлүүд',
            count: favoriteVerses.length,
            onViewAll: onViewAllVerses,
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
              ),
              itemCount: favoriteVerses.length,
              itemBuilder: (context, index) {
                final verse = favoriteVerses[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < favoriteVerses.length - 1
                        ? AppTheme.spacingSmall
                        : 0,
                  ),
                  child: _FavoriteVerseCard(verse: verse, isDark: isDark),
                );
              },
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
        ],
        // Favorite songs
        if (favoriteSongs.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.music_note,
            iconColor: AppColors.secondary,
            title: 'Дуртай дуунууд',
            count: favoriteSongs.length,
            onViewAll: onViewAllSongs,
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
              ),
              itemCount: favoriteSongs.length,
              itemBuilder: (context, index) {
                final song = favoriteSongs[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < favoriteSongs.length - 1
                        ? AppTheme.spacingSmall
                        : 0,
                  ),
                  child: _FavoriteSongCard(song: song, isDark: isDark),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final int count;
  final VoidCallback? onViewAll;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.count,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: AppTheme.spacingSmall),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: iconColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('Бүгдийг харах'),
            ),
        ],
      ),
    );
  }
}

class _FavoriteVerseCard extends StatelessWidget {
  final Verse verse;
  final bool isDark;

  const _FavoriteVerseCard({
    required this.verse,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 200,
      padding: const EdgeInsets.all(AppTheme.spacingSmall),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceContainerDark
            : AppColors.tertiary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              verse.reference,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          Expanded(
            child: Text(
              '"${verse.text}"',
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteSongCard extends StatelessWidget {
  final Song song;
  final bool isDark;

  const _FavoriteSongCard({
    required this.song,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 180,
      padding: const EdgeInsets.all(AppTheme.spacingSmall),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceContainerDark
            : AppColors.surfaceContainerLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
