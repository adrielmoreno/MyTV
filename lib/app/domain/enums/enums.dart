enum SingInFailure {
  notFound,
  unauthorized,
  unknown;

  String get message => switch (this) {
        SingInFailure.notFound => 'User not found',
        SingInFailure.unauthorized => 'Unauthorized',
        SingInFailure.unknown => 'Unknown error'
      };
}
