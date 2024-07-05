part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}

final class SinupLoading extends AuthState {}

final class SinupSuccess extends AuthState {}

final class SinupFailure extends AuthState {
  final String errMessage;

  SinupFailure({required this.errMessage});
}
