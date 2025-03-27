import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../home/views/home_view.dart';
import '../../sign_in/views/sign_in_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final hasInternet = await inject<ConnectivityRepository>().hasIntenert;
    log('Has internet: $hasInternet');

    if (!hasInternet) {
      // _navigateTo(NoInternetView.route);
      return;
    }

    final isSignedIn = await inject<AuthRepository>().isSignedId;
    if (!isSignedIn) {
      _navigateTo(SignInView.route);
      return;
    }

    final user = await inject<AccountRepository>().getUserData();
    if (user == null) {
      _navigateTo(SignInView.route);
      return;
    }

    _navigateTo(HomeView.route);
  }

  _navigateTo(String routeName) {
    context.pushReplacement(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
