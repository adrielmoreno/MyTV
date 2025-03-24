import 'dart:developer';

import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/local/secure_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl(this._secureStorageService);

  @override
  Future<User?> getUserData() {
    return Future.value(
      User(),
    );
  }

  @override
  Future<bool> get isSignedId async {
    try {
      final token = await _secureStorageService.getToken();
      return token != null;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
