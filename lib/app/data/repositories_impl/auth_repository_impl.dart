import 'dart:developer';

import '../../domain/common/result.dart';
import '../../domain/enums/enums.dart';
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

  @override
  Future<Result<SingInFailure, User>> signIn(
      String username, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (username != 'test') {
        return Result.failure(SingInFailure.notFound);
      }

      if (password != '12345678') {
        return Result.failure(SingInFailure.unauthorized);
      }

      await _secureStorageService.saveToken('lasjfllasdflñasfñasd');
      return Result.success(User());
    } catch (e) {
      log(e.toString());
      return Result.failure(SingInFailure.unknown);
    }
  }

  @override
  Future<Result> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result> signUp(String username, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
