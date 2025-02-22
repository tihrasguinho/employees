typedef AsyncResult<T> = Future<Result<T>>;

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok;

  const factory Result.error(String message) = Error;

  bool isOk() => this is Ok;

  T getOk() => switch (this) {
    Ok o => o.value,
    Error _ => throw Exception("Result is not Ok"),
  };

  bool isError() => this is Error;

  String getError() => switch (this) {
    Ok _ => throw Exception("Result is not Error"),
    Error e => e.message,
  };

  S fold<S>(S Function(T ok) whenOk, S Function(String error) whenError) {
    return switch (this) {
      Ok<T> o => whenOk(o.value),
      Error<T> e => whenError(e.message),
    };
  }
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

final class Error<T> extends Result<T> {
  final String message;
  const Error(this.message);
}
