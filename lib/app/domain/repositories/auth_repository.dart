import '../models/user.dart';

abstract class AuthRepository {
  Future<bool> get isSignedId;
  Future<User?> getUserData();
}
