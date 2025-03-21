import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/repositories/connectivity_repository.dart';

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
    final connectivityRepository = inject<ConnectivityRepository>();

    final hasInternet = await connectivityRepository.hasIntenert;

    log('Has internet: $hasInternet');
    if (hasInternet) {
      // Go to home
    } else {
      // Go to no internet
    }
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
