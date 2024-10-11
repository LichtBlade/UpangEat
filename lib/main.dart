import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_bloc.dart';
import 'package:upang_eat/bloc/category_bloc/category_bloc.dart';
import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/bloc/order_bloc/order_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:upang_eat/pages/seller_center/seller_center.dart';
import 'package:upang_eat/repositories/admin_repository_impl.dart';
import 'package:upang_eat/repositories/auth_repository_impl.dart';
import 'package:upang_eat/repositories/category_repository_impl.dart';
import 'package:upang_eat/repositories/food_repository_impl.dart';
import 'package:upang_eat/repositories/order_repository_impl.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
import 'package:upang_eat/repositories/transaction_repository_impl.dart';
import 'package:upang_eat/repositories/tray_repository_impl.dart';
import 'Pages/home.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/tray_bloc/tray_bloc.dart';

void main() {
  runApp(const MyApp());
}

class IpAddress {
  static String get ipAddress => "http://192.168.68.104:3000"; // change ip before running
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
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              authRepository:
                  AuthRepositoryImpl(baseUrl: 'http://localhost:3000')),
        ),

        BlocProvider<AdminBloc>(
          create: (context) => AdminBloc(AdminRepositoryImpl()),
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
      ],
      child: MaterialApp(
        title: "Upang Eat",
        debugShowCheckedModeBanner: false,
        home: const SellerCenter(),
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF8F8F8),
            cardTheme: const CardTheme(color: Colors.white),
            appBarTheme: const AppBarTheme(color: Color(0xFFF8F8F8))),
      ),
    );
  }
}
