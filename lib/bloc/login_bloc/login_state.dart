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

  @override
  List<Object> get props => [userType];
}

final class LoginFailed extends LoginState {
  final String error;

  const LoginFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class UserLoading extends LoginState {}

final class UserLoaded extends LoginState {
  final UserModel user;

  const UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UserFailed extends LoginState {
  final String error;

  const UserFailed(this.error);

  @override
  List<Object> get props => [error];
}

