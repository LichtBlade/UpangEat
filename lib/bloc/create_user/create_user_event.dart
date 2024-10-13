part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserLoadDataEvent extends CreateUserEvent {}

class SubmitUserFormEvent extends CreateUserEvent {
  final String firstName;
  final String lastName;
  final String studentId;
  final String email;
  final String password;
  final String mobile;
  final String userType;

  const SubmitUserFormEvent({
    required this.firstName,
    required this.lastName,
    required this.studentId,
    required this.email,
    required this.password,
    required this.mobile,
    required this.userType,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        studentId,
        email,
        password,
        mobile,
        userType,
      ];
}

class UpdateUserEvent extends CreateUserEvent {
  final int id;
  final String studentId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String mobile;
  final String userType;

  const UpdateUserEvent(
      {required this.id,
      required this.studentId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.mobile,
      required this.userType});
}

class DeleteUserEvent extends CreateUserEvent {
  final int id;

  const DeleteUserEvent({required this.id});

  @override
  List<Object> get props => [id];
}
