part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String userType;

  const LoginSuccess(this.userType);
}

final class LoginFailed extends LoginState {
  final String error;

  const LoginFailed(this.error);
}

