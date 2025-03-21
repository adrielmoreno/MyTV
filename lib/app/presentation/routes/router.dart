import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/views/splash_view.dart';

final _rootNavegationKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavegationKey,
  initialLocation: SplashView.route,
  routes: [
    // root route
    GoRoute(
      path: SplashView.route,
      parentNavigatorKey: _rootNavegationKey,
      builder: (context, state) => const SplashView(),
    ),
  ],
);
