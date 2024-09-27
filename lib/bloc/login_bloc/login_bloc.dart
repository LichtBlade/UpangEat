import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:upang_eat/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      print('Authenticating user with email: ${event.email}'); // debug success login and show email
      final userType = await authRepository.authenticate(
        email: event.email,
        password: event.password,
      );
      print('Authentication successful: User type - $userType'); // debug success login and show usertype

      emit(LoginSuccess(userType: userType));
    } catch (error) {
      print('Authentication failed: $error'); // debugging for auth failure
      emit(LoginFailure(error: error.toString()));
    }
  }
}
