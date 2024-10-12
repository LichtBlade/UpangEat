import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upang_eat/models/user_model.dart';

import 'package:upang_eat/repositories/auth_repository.dart';
import 'package:upang_eat/user_data.dart';

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
        globalUserData = UserModel(email: userData.email, firstName: userData.firstName, lastName: userData.lastName, userId: userData.userId, stallId: userData.stallId,phoneNumber: userData.phoneNumber, userType: userData.userType, stallName: userData.stallName);
        emit(UserLoaded(userData));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userData.userId);
        await prefs.setString('firstName', userData.firstName);
        await prefs.setString('lastName', userData.lastName);
        await prefs.setString('email', userData.email);
        await prefs.setString('phoneNumber', userData.phoneNumber ?? "");
        await prefs.setString('userType', userData.userType ?? "iba to");
        await prefs.setInt('stallId', userData.stallId ?? 0);
        await prefs.setString('stallName', userData.stallName ?? "");
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
        phoneNumber: prefs.getString("phoneNumber")!, userType: prefs.getString("userType")!, stallId: prefs.getInt("stallId")!, stallName: prefs.getString("stallName")!);
        globalUserData = userData;
        emit(UserLoaded(userData));

      } catch (error) {
        emit(UserFailed("Load: $error"));
      }
    });

    on<RemoveUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        globalUserData = const UserModel(userId: 0, firstName: "", lastName: "", email: "", userType: null, phoneNumber: null, stallId: null,stallName: null);
        await prefs.remove('userId');
        await prefs.remove('firstName');
        await prefs.remove('lastName');
        await prefs.remove('email');
        await prefs.remove('phoneNumber');
        await prefs.remove('userType');
        await prefs.remove('stallId');
        await prefs.remove('stallName');
      } catch (error) {
        emit(UserFailed("Remove: $error"));

      }
    });
  }


}
