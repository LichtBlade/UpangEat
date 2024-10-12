part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object?> get props => [];
}

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
