import 'package:flutter/material.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/common/result.dart';
import '../../../../domain/enums/signin_failure.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repositories/auth_repository.dart';

class SignInController extends ChangeNotifier {
  final _usernameController = TextEditingController(text: "morenocreactivo");
  final _passwordController = TextEditingController(text: "KsHD7\$.#amcxCt4");
  final _formKey = GlobalKey<FormState>();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get formKey => _formKey;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Result<SignInFailure, User?>> signIn() async {
    setIsLoading(true);

    final result = await inject<AuthRepository>().signIn(
      _usernameController.text,
      _passwordController.text,
    );

    return result;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
