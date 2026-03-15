import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sss/core/routes/app_routes.dart';
import 'package:sss/views/auth/signin_screen.dart';
import 'package:sss/views/auth/signup_screen.dart';
import 'package:sss/views/home/home_screen.dart';
import 'package:sss/views/splash_screen.dart';

/// App route paths (match [AppRoutes] for consistency).
/// Flow: splash → signin → signup.
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
      GoRoute(
        path: AppRoutes.signin,
        name: 'signin',
        builder: (BuildContext context, GoRouterState state) =>
            const SigninScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: 'signup',
        builder: (BuildContext context, GoRouterState state) =>
            const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
    ],
  );
}
