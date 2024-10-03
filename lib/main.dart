import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Pages/home.dart';
import 'package:upang_eat/Pages/notifications.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Pages/tray.dart';
import 'package:upang_eat/Pages/wallet.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';
import 'package:upang_eat/bloc/category_bloc/category_bloc.dart';
import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:upang_eat/pages/seller_center/seller_center.dart';
import 'package:upang_eat/repositories/auth_repository_impl.dart';
import 'package:upang_eat/repositories/category_repository_impl.dart';
import 'package:upang_eat/repositories/food_repository_impl.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
import 'package:upang_eat/repositories/transaction_repository_impl.dart';
import 'package:upang_eat/widgets/custom_app_bar.dart';
import 'package:upang_eat/widgets/user_login.dart';

import 'bloc/login_bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class IpAddress {
  static String get ipAddress => "http://192.168.100.59:3000";
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // login_bloc
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              authRepository:
                  AuthRepositoryImpl(baseUrl: 'http://localhost:3000')),
        ),
        BlocProvider<StallBloc>(
          create: (context) => StallBloc(StallRepositoryImpl()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(CategoryRepositoryImpl()),
        ),
        BlocProvider<FoodBloc>(
          create: (context) => FoodBloc(FoodRepositoryImpl()),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(TransactionRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
          title: "Upang Eat",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: const Home(),
          ),
    );
  }
}
