import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/login_bloc/login_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/models/user_model.dart';
import 'package:upang_eat/repositories/user_repository.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final UserRepository userRepository;

  CreateUserBloc(this.userRepository) : super(CreateUserInitial()) {
    on<CreateUserLoadDataEvent>(_onUserLoadDataEvent);

    on<SubmitUserFormEvent>(_onSubmitUserForm);

    on<UpdateUserEvent>(_onUpdateStall);

    on<DeleteUserEvent>(_onDeleteStall);
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

  Future<void> _onUpdateStall(
    UpdateUserEvent event,
    Emitter<CreateUserState> emit,
  ) async {
    emit(CreateUserLoading());
    try {
      await userRepository.updateUser(
          event.id,
          event.studentId,
          event.firstName,
          event.lastName,
          event.email,
          event.password,
          event.mobile,
          event.userType);
      emit(const CreateUserSuccess('User Updated Successfully'));
    } catch (error) {
      emit(CreateUserFailure(error.toString()));
    }
  }

  Future<void> _onDeleteStall(
    DeleteUserEvent event,
    Emitter<CreateUserState> emit,
  ) async {
    emit(CreateUserLoading());
    try {
      await userRepository.deleteUser(event.id);
    } catch (error) {
      emit(CreateUserFailure(error.toString()));
    }
  }

  Future<void> _onUserLoadDataEvent(
    CreateUserLoadDataEvent event,
    Emitter<CreateUserState> emit,
  ) async {
    emit(CreateUserLoading());
    try {
      final users = await userRepository.fetchUsers();
      emit(CreateUserLoaded(users: users));
    } catch (error) {
      emit(CreateUserFailure(error.toString()));
    }
  }
}
