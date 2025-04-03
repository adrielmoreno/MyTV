import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_modules.dart';
import '../../../common/controllers/session_controller.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../widgets/movies_and_series/trending_list.dart';
import '../widgets/perfomers/trending_performers.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    final sessionController = inject<SessionController>();
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (_, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              log('message');
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: Column(
                  spacing: 10.0,
                  children: [
                    TrendingList(),
                    TrendingPerformers(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.red,
          onPressed: () {
            sessionController.signOut();
            context.pushReplacement(SignInView.route);
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
