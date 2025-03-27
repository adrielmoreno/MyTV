import 'dart:developer';

import '../../domain/common/result.dart';
import '../../domain/enums/signin_failure.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/local/secure_storage_service.dart';
import '../services/remote/moviedb_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorageService _secureStorageService;
  final MovieDBService _movieDBService;

  AuthRepositoryImpl(this._secureStorageService, this._movieDBService);

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
  Future<Result<SignInFailure, User?>> signIn(
      String username, String password) async {
    try {
      final requestToken = await _movieDBService.createRequestToken();

      if (requestToken == null) return Result.failure(SignInFailure.unknown);

      final loginResult =
          await _movieDBService.createSessionWithLogin(username, password);

      return loginResult.when(
        (failure) => Result.failure(failure),
        (newRequestToken) async {
          final sessionResult = await _movieDBService.createSession(
            newRequestToken,
          );

          return sessionResult.when(
            (failure) => Result.failure(failure),
            (sessionId) async {
              await _secureStorageService.saveToken(sessionId);
              final user = await _movieDBService.getAccountDetails(sessionId);
              return Result.success(user);
            },
          );
        },
      );
    } catch (e) {
      return Result.failure(SignInFailure.unknown);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final token = await _secureStorageService.getToken();
      await _movieDBService.singOut('$token');
      await _secureStorageService.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<Result> signUp(String username, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
