import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upang_eat/models/user_model.dart';

import 'package:upang_eat/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginLoading()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {

        final userData = await authRepository.authenticate(
          event.email,
          event.password,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userData.userId);
        await prefs.setString('firstName', userData.firstName);
        await prefs.setString('lastName', userData.lastName);
        await prefs.setString('email', userData.email);
        await prefs.setString('phoneNumber', userData.phoneNumber!);
        await prefs.setString('userType', userData.userType!);
        emit (LoginSuccess(userData.userType!));

      } catch (error) {
        emit(LoginFailed(error.toString()));
      }
    });

    on<LoadUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final userData = UserModel(userId: prefs.getInt("userId")!, firstName: prefs.getString("firstName")!, lastName: prefs.getString("lastName")!, email: prefs.getString("email")!,
        phoneNumber: prefs.getString("phoneNumber")!, userType: prefs.getString("userType")!);
        emit(UserLoaded(userData));

      } catch (error) {
        emit(UserFailed(error.toString()));
      }
    });

    on<RemoveUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final prefs = await SharedPreferences.getInstance();

        await prefs.remove('userId');
        await prefs.remove('firstName');
        await prefs.remove('lastName');
        await prefs.remove('email');
        await prefs.remove('phoneNumber');
        await prefs.remove('userType');
      } catch (error) {
        emit(UserFailed(error.toString()));
      }
    });
  }


}
