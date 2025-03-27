import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/sign_in_controller.dart';
import '../widgets/submit_button.dart';

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
                      SubmitButton(),
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
}
