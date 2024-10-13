part of 'create_user_bloc.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object?> get props => [];
}

class CreateUserInitial extends CreateUserState {}

class CreateUserLoading extends CreateUserState {}

class CreateUserLoaded extends CreateUserState {
  final List<UserModel> users;

  const CreateUserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class CreateUserSuccess extends CreateUserState {
  final String message;

  const CreateUserSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CreateUserFailure extends CreateUserState {
  final String error;

  const CreateUserFailure(this.error);

  @override
  List<Object> get props => [error];
}
