
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/repositories/user_repository.dart';


part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final UserRepository userRepository;

  CreateUserBloc(this.userRepository) : super(CreateUserInitial()) {
    on<SubmitUserFormEvent>(_onSubmitUserForm);
  }

  Future<void> _onSubmitUserForm(
    SubmitUserFormEvent event,
    Emitter<CreateUserState> emit,
  ) async {
    emit(CreateUserLoading());
    try {
      await userRepository.createUser(
        firstName: event.firstName,
        lastName: event.lastName,
        studentId: event.studentId,
        email: event.email,
        password: event.password,
        mobile: event.mobile,
        userType: event.userType,
      );
      emit(const CreateUserSuccess('User created successfully!'));
    } catch (error) {
      emit(CreateUserFailure(error.toString()));
    }
  }
}
