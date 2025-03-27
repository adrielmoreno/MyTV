import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../common/extensions/widget_extensions.dart';
import '../../home/views/home_view.dart';
import '../controller/sign_in_controller.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String route = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(builder: (context) {
              final controller = context.watch<SignInController>();
              return Form(
                key: controller.formKey,
                child: AbsorbPointer(
                  absorbing: controller.isLoading,
                  child: Column(
                    spacing: 20.0,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      controller.isLoading
                          ? CircularProgressIndicator()
                          : MaterialButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                final isValid =
                                    controller.formKey.currentState!.validate();
                                if (isValid) {
                                  signIn(context);
                                }
                              },
                              child: const Text('Sign In')),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    final SignInController controller = context.read();

    controller.setIsLoading(true);

    final result = await inject<AuthRepository>().signIn(
      controller.usernameController.text,
      controller.passwordController.text,
    );

    result.when(
      (failure) {
        context.showSnackBar(
          failure.message,
        );
      },
      (user) {
        context.pushReplacement(HomeView.route);
      },
    );

    controller.setIsLoading(false);
  }
}
