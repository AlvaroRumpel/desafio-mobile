part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function() success,
    required T Function(String message) error,
  }) {
    if (this is LoginInitial) {
      return initial();
    } else if (this is LoginLoading) {
      return loading();
    } else if (this is LoginSuccess) {
      return success();
    } else if (this is LoginError) {
      return error((this as LoginError).message);
    }
    throw Exception('Unreachable');
  }

  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function(String message)? error,
    required T? Function() orElse,
  }) {
    if (this is LoginInitial && initial != null) {
      return initial();
    } else if (this is LoginLoading && loading != null) {
      return loading();
    } else if (this is LoginSuccess && success != null) {
      return success();
    } else if (this is LoginError && error != null) {
      return error((this as LoginError).message);
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function(String message)? error,
  }) {
    return maybeWhen(
      initial: initial,
      loading: loading,
      success: success,
      error: error,
      orElse: () => null,
    );
  }

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object?> get props => [message];
}
