import 'dart:developer';

import '../../domain/models/user/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/local/secure_storage_service.dart';
import '../services/remote/moviedb_service.dart';

class AccountRepositoryImpl implements AccountRepository {
  final MovieDBService _movieDBService;
  final SecureStorageService _secureStorageService;
  AccountRepositoryImpl(this._movieDBService, this._secureStorageService);
  @override
  Future<User?> getUserData() async {
    try {
      final token = await _secureStorageService.getToken();
      return await _movieDBService.getAccountDetails('$token');
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
