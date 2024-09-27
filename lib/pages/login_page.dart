import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/login_bloc/login_state.dart';
import '../repositories/auth_repository_impl.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: AuthRepositoryImpl(baseUrl: 'http://localhost:3000'),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in...')));
            } else if (state is LoginSuccess) {
              if (state.userType == 'admin') {
                // to do: navigate to admin dashboard
              } else if (state.userType == 'stall_owner') {
                // to do: navigate to stall owner dashboard
              } else {
                // to do: navigate to user dashboard
              }
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: ${state.error}')));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Dispatch login event
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPressed(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
