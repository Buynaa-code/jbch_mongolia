import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/favorites_section.dart';
import '../widgets/settings_tile.dart';

/// Profile page displaying user info, favorites, and settings
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: const _ProfilePageContent(),
    );
  }
}

class _ProfilePageContent extends StatelessWidget {
  const _ProfilePageContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Профайл',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileCubit>().loadProfile();
                    },
                    child: const Text('Дахин оролдох'),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<ProfileCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User profile header
                    _ProfileHeader(
                      name: state.user.name,
                      email: state.user.email,
                      memberSince: state.user.memberSince,
                      imageUrl: state.user.profileImageUrl,
                      isDark: isDark,
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),
                    // Favorites section
                    FavoritesSection(
                      favoriteVerses: state.favoriteVerses,
                      favoriteSongs: state.favoriteSongs,
                      onViewAllVerses: () {
                        context.go('/library');
                      },
                      onViewAllSongs: () {
                        context.go('/library');
                      },
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),
                    // Settings sections
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, themeState) {
                        return SettingsSection(
                          title: 'Төрх',
                          children: [
                            SettingsTile(
                              icon: Icons.palette_outlined,
                              iconColor: AppColors.accent,
                              title: 'Харанхуй горим',
                              subtitle: _getThemeModeText(themeState.themeMode),
                              trailing: SegmentedButton<ThemeMode>(
                                segments: const [
                                  ButtonSegment(
                                    value: ThemeMode.light,
                                    icon: Icon(Icons.light_mode, size: 18),
                                  ),
                                  ButtonSegment(
                                    value: ThemeMode.system,
                                    icon: Icon(Icons.brightness_auto, size: 18),
                                  ),
                                  ButtonSegment(
                                    value: ThemeMode.dark,
                                    icon: Icon(Icons.dark_mode, size: 18),
                                  ),
                                ],
                                selected: {themeState.themeMode},
                                onSelectionChanged: (modes) {
                                  context
                                      .read<ThemeCubit>()
                                      .setThemeMode(modes.first);
                                },
                                showSelectedIcon: false,
                                style: ButtonStyle(
                                  visualDensity: VisualDensity.compact,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              showDivider: false,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    SettingsSection(
                      title: 'Мэдэгдэл',
                      children: [
                        SettingsTile(
                          icon: Icons.notifications_outlined,
                          iconColor: AppColors.secondary,
                          title: 'Мэдэгдэл',
                          subtitle: state.notificationsEnabled
                              ? 'Идэвхтэй'
                              : 'Идэвхгүй',
                          trailing: Switch(
                            value: state.notificationsEnabled,
                            onChanged: (_) {
                              context
                                  .read<ProfileCubit>()
                                  .toggleNotifications();
                            },
                          ),
                          showDivider: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    SettingsSection(
                      title: 'Тусламж',
                      children: [
                        SettingsTile(
                          icon: Icons.help_outline,
                          iconColor: AppColors.primary,
                          title: 'Тусламж',
                          onTap: () {
                            // TODO: Navigate to help
                          },
                        ),
                        SettingsTile(
                          icon: Icons.info_outline,
                          iconColor: AppColors.primaryLight,
                          title: 'Апп-ын тухай',
                          subtitle: 'Хувилбар 1.0.0',
                          onTap: () {
                            // TODO: Show about dialog
                          },
                          showDivider: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXLarge),
                    // Sign out button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMedium,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Sign out
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Гарах'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(
                              vertical: AppTheme.spacingMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXLarge),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Цагаан';
      case ThemeMode.dark:
        return 'Харанхуй';
      case ThemeMode.system:
        return 'Системийн';
    }
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String memberSince;
  final String? imageUrl;
  final bool isDark;

  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.memberSince,
    this.imageUrl,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingMedium),
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
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
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: imageUrl != null
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(width: AppTheme.spacingMedium),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Гишүүн: $memberSince-аас',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // Edit button
          IconButton(
            onPressed: () {
              // TODO: Edit profile
            },
            icon: const Icon(Icons.edit_outlined),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
