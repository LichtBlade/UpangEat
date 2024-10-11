import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:upang_eat/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginLoading()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {

        final userType = await authRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        emit (LoginSuccess(userType));

      } catch (error) {
        emit(LoginFailed(error.toString()));
      }
    });
  }

  // Future<void> _onLoginButtonPressed(
  //     LoginButtonPressed event, Emitter<LoginState> emit) async {
  //   emit(LoginLoading());
  //
  //   try {
  //     print('Authenticating user with email: ${event.email}'); // debug success login and show email
  //     final userType = await authRepository.authenticate(
  //       email: event.email,
  //       password: event.password,
  //     );
  //     print('Authentication successful: User type - $userType'); // debug success login and show usertype
  //
  //     emit(LoginSuccess(userType: userType));
  //   } catch (error) {
  //     print('Authentication failed: $error'); // debugging for auth failure
  //     emit(LoginFailed(error: error.toString()));
  //   }
  // }
}
