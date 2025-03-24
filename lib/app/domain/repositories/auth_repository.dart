import '../common/result.dart';
import '../enums/enums.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<bool> get isSignedId;
  Future<User?> getUserData();
  Future<Result<SingInFailure, User>> signIn(
    String username,
    String password,
  );
  Future<Result> signOut();
  Future<Result> signUp(String username, String password);
}
