import '../common/result.dart';
import '../enums/signin_failure.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<bool> get isSignedId;
  Future<Result<SignInFailure, User?>> signIn(
    String username,
    String password,
  );
  Future<void> signOut();
  Future<Result> signUp(String username, String password);
}
