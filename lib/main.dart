import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_bloc.dart';
import 'package:upang_eat/bloc/category_bloc/category_bloc.dart';
import 'package:upang_eat/bloc/create_user/create_user_bloc.dart';
import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/bloc/order_bloc/order_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:upang_eat/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:upang_eat/pages/seller_center/seller_center.dart';
import 'package:upang_eat/repositories/admin_repository_impl.dart';
import 'package:upang_eat/repositories/auth_repository_impl.dart';
import 'package:upang_eat/repositories/category_repository_impl.dart';
import 'package:upang_eat/repositories/food_repository_impl.dart';
import 'package:upang_eat/repositories/order_repository_impl.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
import 'package:upang_eat/repositories/transaction_repository_impl.dart';
import 'package:upang_eat/repositories/tray_repository_impl.dart';

import 'package:upang_eat/repositories/user_repository_impl.dart';

import 'package:upang_eat/pages/user_login.dart';
import 'Pages/home.dart';

import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/tray_bloc/tray_bloc.dart';

void main() {
  runApp(const MyApp());
}

// For Platform detection

class IpAddress {
  static String get ipAddress {
    if (Platform.isIOS) {
      return "http://localhost:3000"; // iOS uses localhost
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:3000"; // Android emulator uses this IP
    } else {
      return "http://defaultAddress:3000"; // Default case if platform is unknown
    }
  }

  static String get rpGanacheUrl {
    if (Platform.isIOS) {
      return "http://localhost:7545"; // iOS uses localhost
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:3000"; // Android emulator uses this IP
    } else {
      return "http://defaultAddress:7545"; // Default case if platform is unknown
    }
  }

  static String get wsGanacheUrl {
    if (Platform.isIOS) {
      return "ws://localhost:7545"; // iOS uses localhost
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:3000"; // Android emulator uses this IP
    } else {
      return "ws://defaultAddress:7545"; // Default case if platform is unknown
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(AuthRepositoryImpl()),
        ),
        BlocProvider<AdminBloc>(
          create: (context) => AdminBloc(StallRepositoryImpl()),
        ),
        //create_user
        BlocProvider<CreateUserBloc>(
          create: (context) => CreateUserBloc(
            UserRepositoryImpl(baseUrl: IpAddress.ipAddress),
          ),
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
        BlocProvider<TrayBloc>(
          create: (context) => TrayBloc(TrayRepositoryImpl()),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(OrderRepositoryImpl()),
        ),
        BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Upang Eat",
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF8F8F8),
            cardTheme: const CardTheme(color: Colors.white),
            appBarTheme: const AppBarTheme(color: Color(0xFFF8F8F8))),
        //temporary for testing, uncomment if done
        // home: const Home(),

        //test for admin
        home: const UserLogin(),

        //test for login
        // home: LoginPage(),
      ),
    );
  }
}
