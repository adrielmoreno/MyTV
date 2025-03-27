import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/widget_extensions.dart';
import '../../home/views/home_view.dart';
import '../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SignInController controller = context.watch();
    return controller.isLoading
        ? CircularProgressIndicator()
        : MaterialButton(
            color: Colors.blueAccent,
            onPressed: () {
              final isValid = controller.formKey.currentState!.validate();
              if (isValid) {
                signIn(context);
              }
            },
            child: const Text('Sign In'));
  }

  Future<void> signIn(BuildContext context) async {
    final SignInController controller = context.read();

    final result = await controller.signIn();

    result.when(
      (failure) {
        context.showSnackBar(
          failure.message,
        );
      },
      (user) {
        controller.setIsLoading(false);
        context.pushReplacement(HomeView.route);
      },
    );
  }
}
