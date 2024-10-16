part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email,password];
}

class LoadUserData extends LoginEvent {
  // final UserModel user;
  //
  // const LoadUserData(this.user);
  //
  // @override
  // List<Object> get props => [user];
}

class RemoveUserData extends LoginEvent{}
