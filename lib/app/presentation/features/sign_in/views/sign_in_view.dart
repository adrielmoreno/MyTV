import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../data/repositories_impl/auth_repository_impl.dart';
import '../../../common/extensions/widget_extensions.dart';
import '../../home/views/home_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});
  static const String route = '/sign-in';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: AbsorbPointer(
              absorbing: _isLoading,
              child: Column(
                spacing: 20.0,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _usernameController,
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
                    controller: _passwordController,
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
                  _isLoading
                      ? CircularProgressIndicator()
                      : MaterialButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            final isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              signIn();
                            }
                          },
                          child: const Text('Sign In')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });

    final result = await inject<AuthRepositoryImpl>().signIn(
      _usernameController.text,
      _passwordController.text,
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

    setState(() {
      _isLoading = false;
    });
  }
}
