import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/token_storage.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Enhanced splash screen with spiritual aesthetic and smooth animations
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for animation
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    try {
      final tokenStorage = getIt<TokenStorage>();
      final accessToken = await tokenStorage.getAccessToken();

      if (!mounted) return;

      if (accessToken != null) {
        context.go(AppRoutes.home);
      } else {
        context.go(AppRoutes.login);
      }
    } catch (e) {
      if (mounted) {
        context.go(AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.tertiary,
                  AppColors.surfaceLight,
                  AppColors.primaryLight.withValues(alpha: 0.1),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Decorative circles - spiritual/peaceful aesthetic
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.primary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  duration: 3000.ms,
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.2, 1.2),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  duration: 3000.ms,
                  begin: const Offset(1.2, 1.2),
                  end: const Offset(1.0, 1.0),
                  curve: Curves.easeInOut,
                ),
          ),

          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.15),
                    AppColors.secondary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  duration: 4000.ms,
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.3, 1.3),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  duration: 4000.ms,
                  begin: const Offset(1.3, 1.3),
                  end: const Offset(1.0, 1.0),
                  curve: Curves.easeInOut,
                ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                // App icon with enhanced animations
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 5,
                        offset: const Offset(0, 20),
                      ),
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        blurRadius: 80,
                        spreadRadius: 10,
                        offset: const Offset(0, 30),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/app_icon.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryLight,
                                AppColors.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            Icons.church,
                            size: 90,
                            color: theme.colorScheme.onPrimary,
                          ),
                        );
                      },
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                    .scale(
                      duration: 800.ms,
                      begin: const Offset(0.7, 0.7),
                      curve: Curves.elasticOut,
                    )
                    .shimmer(
                      delay: 800.ms,
                      duration: 1500.ms,
                      color: AppColors.onPrimary.withValues(alpha: 0.3),
                    ),

                const SizedBox(height: AppTheme.spacingXLarge),

                // App name with staggered animation
                Text(
                  'JBCH Mongolia',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: AppTheme.spacingMedium),

                // Tagline with subtle entrance
                Text(
                  'Сүнслэг амьдралын хамтрагч',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.primary.withValues(alpha: 0.8),
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 700.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                const Spacer(flex: 3),

                // Elegant loading indicator
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary.withValues(alpha: 0.8),
                        ),
                      ),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(duration: 800.ms)
                        .scale(
                          duration: 1000.ms,
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.0, 1.0),
                        ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    Text(
                      'Ачаалж байна...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(delay: 1000.ms, duration: 800.ms)
                        .then()
                        .fadeOut(duration: 800.ms)
                        .then()
                        .fadeIn(duration: 800.ms),
                  ],
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
