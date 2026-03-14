import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sss/core/routes/app_routes.dart';
import 'package:sss/views/splash_screen.dart';

/// App route paths (match [AppRoutes] for consistency).
final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      // Add more routes here, e.g.:
      // GoRoute(path: AppRoutes.home, name: 'home', builder: (_, state) => const HomeScreen()),
    ],
  );
}
