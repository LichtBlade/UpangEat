import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Pages/home.dart';
import 'package:upang_eat/Pages/notifications.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Pages/tray.dart';
import 'package:upang_eat/Pages/wallet.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/repositories/auth_repository_impl.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
import 'package:upang_eat/widgets/app_bar_home.dart';
import 'package:upang_eat/widgets/user_login.dart';

import 'bloc/login_bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _pages = [
    const Home(),
    const Stalls(),
    const Notifications(),
    const Tray(),
  ];

  final List<String> _appBarTitle = [
    'UPANG Eats',
    "Stalls",
    "Notifications",
    "Tray"
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // stall_bloc
        BlocProvider(
          create: (context) => StallBloc(StallRepositoryImpl()),
        ),
        // login_bloc
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              authRepository:
                  AuthRepositoryImpl(baseUrl: 'http://localhost:3000')),
        ),
      ],
      child: MaterialApp(
          title: "Upang Eat",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          
          initialRoute: '/home',
          routes: {
            '/login': (context) => LoginPage(),
            '/home': (context) => const Scaffold(
                  appBar: AppBarHome(),
                  drawer: CustomDrawer(),
                  body: Home(),
                ),
          }),
    );
  }
}
