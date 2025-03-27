enum SignInFailure {
  notFound,
  unauthorized,
  network,
  unknown;

  String get message => switch (this) {
        SignInFailure.notFound => 'User not found',
        SignInFailure.unauthorized => 'Unauthorized',
        SignInFailure.network => 'Network error',
        SignInFailure.unknown => 'Unknown error'
      };
}
