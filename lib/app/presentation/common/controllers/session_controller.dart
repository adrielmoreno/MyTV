import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../core/di/app_modules.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/auth_repository.dart';

class SessionController extends ChangeNotifier {
  late User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    log('User set: ${user?.username}');
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    await inject<AuthRepository>().signOut();
    notifyListeners();
  }
}
