import '../errors/failure.dart';

/// {@template result}
/// A typed [Result] wrapper that forces callers to handle success and failure.
///
/// [S] is the success value type, [F] is the failure type (defaults to
/// [Failure]).
/// {@endtemplate}
sealed class Result<S, F> {
  /// {@macro result}
  const Result();

  /// Creates a successful result.
  factory Result.success(S value) => Success<S, F>._(value);

  /// Creates a failed result.
  factory Result.failure(F failure) => FailureResult<S, F>._(failure);

  /// Returns true when the result is a success.
  bool get isSuccess => this is Success<S, F>;

  /// Returns true when the result is a failure.
  bool get isFailure => this is FailureResult<S, F>;

  /// Returns the success value or null if failure.
  S? get valueOrNull => switch (this) {
    Success<S, F>(value: final S value) => value,
    _ => null,
  };

  /// Returns the failure value or null if success.
  F? get failureOrNull => switch (this) {
    FailureResult<S, F>(failure: final F failure) => failure,
    _ => null,
  };

  /// Folds the result into a single value.
  T when<T>({
    required T Function(S value) success,
    required T Function(F failure) failure,
  }) => switch (this) {
    Success<S, F>(value: final S value) => success(value),
    FailureResult<S, F>(failure: final F failureValue) => failure(failureValue),
  };

  /// Maps a success value to another type.
  Result<T, F> map<T>(T Function(S value) mapper) => switch (this) {
    Success<S, F>(value: final S value) => Result<T, F>.success(mapper(value)),
    FailureResult<S, F>(failure: final F failure) => Result<T, F>.failure(
      failure,
    ),
  };

  /// Maps a failure value to another type.
  Result<S, T> mapFailure<T>(T Function(F failure) mapper) => switch (this) {
    Success<S, F>(value: final S value) => Result<S, T>.success(value),
    FailureResult<S, F>(failure: final F failure) => Result<S, T>.failure(
      mapper(failure),
    ),
  };

  /// Runs [sideEffect] only for success.
  Result<S, F> onSuccess(void Function(S value) sideEffect) {
    if (this case Success<S, F>(value: final S value)) {
      sideEffect(value);
    }
    return this;
  }

  /// Runs [sideEffect] only for failure.
  Result<S, F> onFailure(void Function(F failure) sideEffect) {
    if (this case FailureResult<S, F>(failure: final F failure)) {
      sideEffect(failure);
    }
    return this;
  }
}

/// {@template success}
/// Success branch of [Result].
/// {@endtemplate}
final class Success<S, F> extends Result<S, F> {
  const Success._(this.value);

  /// The success value.
  final S value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<S, F> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success(value: $value)';
}

/// {@template failure_result}
/// Failure branch of [Result].
/// {@endtemplate}
final class FailureResult<S, F> extends Result<S, F> {
  const FailureResult._(this.failure);

  /// The failure value.
  final F failure;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FailureResult<S, F> && other.failure == failure;
  }

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'FailureResult(failure: $failure)';
}
