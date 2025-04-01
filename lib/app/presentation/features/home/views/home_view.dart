import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_modules.dart';
import '../../../common/controllers/session_controller.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../widgets/trending_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    final sessionController = inject<SessionController>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: TrendingList()),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  sessionController.signOut();
                  context.pushReplacement(SignInView.route);
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
