import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/events/presentation/pages/event_detail_page.dart';
import '../../features/events/presentation/pages/events_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/library/presentation/pages/song_player_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../shared/widgets/main_scaffold.dart';
import '../di/injection.dart';
import '../network/token_storage.dart';

/// Application route paths
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
  static const String events = '/events';
  static const String eventDetail = '/events/:id';
  static const String library = '/library';
  static const String songPlayer = '/library/song/:id';
  static const String profile = '/profile';
}

/// Application router configuration using go_router
/// Uses StatefulShellRoute for bottom navigation with state preservation
final class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final GlobalKey<NavigatorState> _shellNavigatorEventsKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellEvents');
  static final GlobalKey<NavigatorState> _shellNavigatorLibraryKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellLibrary');
  static final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  /// Routes that don't require authentication
  static const List<String> _publicRoutes = [
    AppRoutes.splash,
    AppRoutes.login,
    AppRoutes.register,
  ];

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: _authRedirect,
    routes: [
      // Splash screen route
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashPage(),
        ),
      ),
      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginPage(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const RegisterPage(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          // Events Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorEventsKey,
            routes: [
              GoRoute(
                path: AppRoutes.events,
                name: 'events',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: EventsPage(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: 'eventDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final eventId = state.pathParameters['id'] ?? '';
                      return MaterialPage(
                        child: EventDetailPage(eventId: eventId),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // Library Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorLibraryKey,
            routes: [
              GoRoute(
                path: AppRoutes.library,
                name: 'library',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: LibraryPage(),
                ),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
      // Full-screen routes outside the shell
      GoRoute(
        path: '/library/song/:id',
        name: 'songPlayer',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final songId = state.pathParameters['id'] ?? '';
          return MaterialPage(
            child: SongPlayerPage(songId: songId),
          );
        },
      ),
    ],
  );

  /// Auth redirect guard
  /// Redirects unauthenticated users to login page for protected routes
  static Future<String?> _authRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final currentPath = state.matchedLocation;

    // Skip auth check for public routes
    if (_publicRoutes.contains(currentPath)) {
      return null;
    }

    // Check if user is authenticated
    try {
      final tokenStorage = getIt<TokenStorage>();
      final accessToken = await tokenStorage.getAccessToken();

      if (accessToken == null) {
        // Not authenticated, redirect to login
        return AppRoutes.login;
      }
    } catch (e) {
      // If DI not ready or error, allow navigation (handled by splash)
      return null;
    }

    return null;
  }
}
