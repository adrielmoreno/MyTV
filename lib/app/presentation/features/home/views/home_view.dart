import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../data/repositories_impl/auth_repository_impl.dart';
import '../../splash/views/splash_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MaterialButton(
            color: Colors.red,
            onPressed: () {
              inject<AuthRepositoryImpl>().signOut();
              context.pushReplacement(SplashView.route);
            },
            child: Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}
