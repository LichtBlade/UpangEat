import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/login_bloc/login_state.dart';
import '../repositories/auth_repository_impl.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: AuthRepositoryImpl(baseUrl: 'http://localhost:3000'),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging in...')),
            );
            } else if (state is LoginSuccess) {
                // base on user type
                if (state.userType == 'admin') {
                  // admin
                } else if (state.userType == 'stall_owner') {
                  // stall owner
                } else {
                  // user
                }
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Failed: ${state.error}')),
            );
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _header(), 
                  _inputField(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    return const Column(
      children: [
        Image(
          image: AssetImage("assets/slazzer-edit-image.png"),
          width: 200,
          height: 200,
        ),
        Text(
          "Log In",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
        ),

        const SizedBox(height: 10),

        // Login Button
        ElevatedButton(
          onPressed: () {
             print('Login button pressed'); //debugging - just show when button is pressed
            BlocProvider.of<LoginBloc>(context).add(
              LoginButtonPressed(
                email: emailController.text,
                password: passwordController.text,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16)),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}