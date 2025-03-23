import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/views/home_view.dart';
import '../features/sign_in/views/sign_in_view.dart';
import '../features/splash/views/splash_view.dart';

class AppRouter {
  // Navigation keys
  static final _rootNavegationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavegationKey,
    initialLocation: SplashView.route,
    routes: [
      // root route
      _singleRoute(
        path: SplashView.route,
        parentKey: _rootNavegationKey,
        page: const SplashView(),
      ),
      // Sign In
      _singleRoute(
        path: SignInView.route,
        parentKey: _rootNavegationKey,
        page: const SignInView(),
      ),
      // Sign In
      _singleRoute(
        path: HomeView.route,
        parentKey: _rootNavegationKey,
        page: const HomeView(),
      ),
    ],
  );

  static GoRoute _singleRoute({
    required String path,
    required Widget page,
    GlobalKey<NavigatorState>? parentKey,
  }) {
    return GoRoute(
      path: path,
      parentNavigatorKey: parentKey,
      pageBuilder: (context, state) => _fadeTransition(page),
    );
  }

  static CustomTransitionPage<dynamic> _fadeTransition(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
