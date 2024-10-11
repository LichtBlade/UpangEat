import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upang_eat/Pages/home.dart';
import 'package:upang_eat/pages/admin_pages/admin_dashboard.dart';
import 'package:upang_eat/pages/seller_center/seller_center.dart';
import 'package:upang_eat/user_data.dart';
import '../bloc/login_bloc/login_bloc.dart';
class UserLogin extends StatefulWidget {

  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();

}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    context.read<LoginBloc>().add(LoadUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is UserLoading) {
              print("UserLoading");
            } else if (state is UserLoaded){
              print("Loaded");
              globalUserData = state.user;
              print(globalUserData);
            }
            if (state is LoginLoading) {
              isLoading = true;
            } else if (state is LoginSuccess) {
              isLoading = false;
              if (state.userType == 'admin') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AdminDashboard()),
                );
              } else if (state.userType == 'stall_owner') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SellerCenter()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
            } else if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Failed: ${state.error}')),
              );
            }

          },
          child: SizedBox(
            // width: double.infinity,
            // height: double.infinity,
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/slazzer-edit-image.png"),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Log In",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  child: Column(
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
                          prefixIcon: const Icon(Icons.person),
                        ),
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
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginButtonPressed(emailController.text,passwordController.text,),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                isLoading ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: Container(
                      color: Colors.black54,
                      child: const Center(child: CircularProgressIndicator())
                  ),
                ): const SizedBox.shrink(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}