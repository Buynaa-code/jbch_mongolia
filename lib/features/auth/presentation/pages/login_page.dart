import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// Enhanced login page with professional spiritual design
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      context.read<AuthCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                margin: const EdgeInsets.all(AppTheme.spacingMedium),
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Gradient background
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
                    AppColors.backgroundLight,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),

            // Decorative top circle
            Positioned(
              top: -120,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scale(
                    duration: 4000.ms,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.15, 1.15),
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    duration: 4000.ms,
                    begin: const Offset(1.15, 1.15),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.easeInOut,
                  ),
            ),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLarge,
                  vertical: AppTheme.spacingMedium,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.08),

                      // App icon
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
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
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Icon(
                                    Icons.church,
                                    size: 50,
                                    color: AppColors.onPrimary,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .scale(
                              duration: 600.ms,
                              begin: const Offset(0.8, 0.8),
                              curve: Curves.easeOut,
                            ),
                      ),

                      const SizedBox(height: AppTheme.spacingLarge),

                      // App name
                      Text(
                        'JBCH Mongolia',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

                      const SizedBox(height: AppTheme.spacingSmall),

                      // Welcome text
                      Text(
                        'Тавтай морил',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.onSurfaceVariantLight,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

                      const SizedBox(height: AppTheme.spacingXLarge + 8),

                      // Login card
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingLarge),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXLarge),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: AppColors.shadowLight.withValues(alpha: 0.05),
                              blurRadius: 48,
                              offset: const Offset(0, 16),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email field
                            _buildInputField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              nextFocusNode: _passwordFocusNode,
                              label: 'И-мэйл',
                              hint: 'example@mail.com',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'И-мэйл хаягаа оруулна уу';
                                }
                                final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Зөв и-мэйл хаяг оруулна уу';
                                }
                                return null;
                              },
                            )
                                .animate()
                                .fadeIn(delay: 600.ms, duration: 500.ms)
                                .slideX(
                                  begin: -0.1,
                                  end: 0,
                                  curve: Curves.easeOut,
                                ),

                            const SizedBox(height: AppTheme.spacingMedium),

                            // Password field
                            _buildPasswordField()
                                .animate()
                                .fadeIn(delay: 700.ms, duration: 500.ms)
                                .slideX(
                                  begin: -0.1,
                                  end: 0,
                                  curve: Curves.easeOut,
                                ),

                            const SizedBox(height: AppTheme.spacingLarge + 8),

                            // Login button
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                final isLoading = state is AuthLoading;
                                return SizedBox(
                                  height: 56,
                                  child: FilledButton(
                                    onPressed: isLoading ? null : _onLoginPressed,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.onPrimary,
                                      elevation: isLoading ? 0 : 2,
                                      shadowColor: AppColors.primary
                                          .withValues(alpha: 0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          AppTheme.radiusMedium,
                                        ),
                                      ),
                                      textStyle:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    child: isLoading
                                        ? SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                AppColors.onPrimary,
                                              ),
                                            ),
                                          )
                                        : const Text('Нэвтрэх'),
                                  ),
                                );
                              },
                            )
                                .animate()
                                .fadeIn(delay: 800.ms, duration: 500.ms)
                                .scale(
                                  delay: 800.ms,
                                  duration: 500.ms,
                                  begin: const Offset(0.95, 0.95),
                                  curve: Curves.easeOut,
                                ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 600.ms)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            curve: Curves.easeOut,
                          ),

                      const SizedBox(height: AppTheme.spacingLarge),

                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Бүртгэл байхгүй юу? ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.onSurfaceVariantLight,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/register'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.spacingSmall,
                                vertical: AppTheme.spacingXSmall,
                              ),
                            ),
                            child: Text(
                              'Бүртгүүлэх',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: 900.ms, duration: 500.ms)
                          .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),

                      const SizedBox(height: AppTheme.spacingMedium),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (mounted) setState(() {});
      },
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction:
            nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onFieldSubmitted: (_) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        style: AppTextStyles.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: focusNode.hasFocus
                ? AppColors.primary
                : AppColors.onSurfaceVariantLight,
          ),
          filled: true,
          fillColor: focusNode.hasFocus
              ? AppColors.surfaceContainerLight
              : AppColors.backgroundLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide(
              color: AppColors.outlineLight.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 2,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Focus(
      onFocusChange: (hasFocus) {
        if (mounted) setState(() {});
      },
      child: TextFormField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        obscureText: _obscurePassword,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => _onLoginPressed(),
        style: AppTextStyles.bodyLarge,
        decoration: InputDecoration(
          labelText: 'Нууц үг',
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: _passwordFocusNode.hasFocus
                ? AppColors.primary
                : AppColors.onSurfaceVariantLight,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: _passwordFocusNode.hasFocus
                  ? AppColors.primary
                  : AppColors.onSurfaceVariantLight,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          filled: true,
          fillColor: _passwordFocusNode.hasFocus
              ? AppColors.surfaceContainerLight
              : AppColors.backgroundLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide(
              color: AppColors.outlineLight.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Нууц үгээ оруулна уу';
          }
          if (value.length < 6) {
            return 'Нууц үг хамгийн багадаа 6 тэмдэгт байх ёстой';
          }
          return null;
        },
      ),
    );
  }
}
