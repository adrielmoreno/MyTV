class Result<Failure, Success> {
  final Failure? failure;
  final Success? success;
  final bool isFailure;

  Result._(this.failure, this.success, this.isFailure);

  factory Result.failure(Failure f) => Result._(f, null, true);
  factory Result.success(Success s) => Result._(null, s, false);

  T when<T>(T Function(Failure) onFailure, T Function(Success) onSuccess) {
    if (isFailure) {
      return onFailure(failure as Failure);
    } else {
      return onSuccess(success as Success);
    }
  }
}
