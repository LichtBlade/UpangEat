import 'dart:io';
import 'dart:convert';

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
import 'package:http/http.dart' as http;
import 'package:upang_eat/repositories/user_repository_impl.dart';
import 'package:upang_eat/user_data.dart';
import 'package:upang_eat/pages/user_login.dart';
import 'Pages/home.dart';

import 'bloc/analytic_food_bloc/analytic_food_bloc.dart';
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
      return "http://192.168.68.106:3000"; // Android emulator uses this IP
    } else {
      return "http://defaultAddress:3000"; // Default case if platform is unknown
    }
  }

  static String get rpGanacheUrl {
    if (Platform.isIOS) {
      return "http://localhost:7545"; // iOS uses localhost
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:7545"; // Android emulator uses this IP
    } else {
      return "http://defaultAddress:7545"; // Default case if platform is unknown
    }
  }

  static String get wsGanacheUrl {
    if (Platform.isIOS) {
      return "ws://localhost:7545"; // iOS uses localhost
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:7545"; // Android emulator uses this IP
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
    fetchTokenPrices();
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
        BlocProvider<AnalyticFoodBloc>(
          create: (context) => AnalyticFoodBloc(FoodRepositoryImpl()),
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

  Future<void> fetchTokenPrices() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/simple/price?ids=ethereum,bitcoin,litecoin,ripple,axie-infinity&vs_currencies=php&include_24hr_change=true'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      // Call updatePrices to update global variables
      updatePrices(data);

      // You can then use the global variables for display or other logic
      print("Ethereum Price: $globalEthPrice");
      print("Bitcoin Price: $globalBtcPrice");
      print("Litecoin Price: $globalLtcPrice");
    } else {
      throw Exception('Failed to load token prices');
    }
  }

  void updatePrices(Map<String, dynamic> data) {
    // Set prices
    double ethPrice = data['ethereum']['php'] != null
        ? (data['ethereum']['php'] is int
            ? (data['ethereum']['php'] as int).toDouble()
            : data['ethereum']['php'])
        : 0.0;
    double btcPrice = data['bitcoin']['php'] != null
        ? (data['bitcoin']['php'] is int
            ? (data['bitcoin']['php'] as int).toDouble()
            : data['bitcoin']['php'])
        : 0.0;
    double ltcPrice = data['litecoin']['php'] != null
        ? (data['litecoin']['php'] is int
            ? (data['litecoin']['php'] as int).toDouble()
            : data['litecoin']['php'])
        : 0.0;
    double xrpPrice = data['ripple']['php'] != null
        ? (data['ripple']['php'] is int
            ? (data['ripple']['php'] as int).toDouble()
            : data['ripple']['php'])
        : 0.0;
    double axsPrice = data['axie-infinity']['php'] != null
        ? (data['axie-infinity']['php'] is int
            ? (data['axie-infinity']['php'] as int).toDouble()
            : data['axie-infinity']['php'])
        : 0.0;

    // Update global variables with price values
    globalEthPrice = ethPrice;
    globalBtcPrice = btcPrice;
    globalLtcPrice = ltcPrice;
    globalXrpPrice = xrpPrice;
    globalAxsPrice = axsPrice;

    // Set price change values
    double ethPriceChange = data['ethereum']['php_24h_change'] ?? 0.0;
    double btcPriceChange = data['bitcoin']['php_24h_change'] ?? 0.0;
    double ltcPriceChange = data['litecoin']['php_24h_change'] ?? 0.0;
    double xrpPriceChange = data['ripple']['php_24h_change'] ?? 0.0;
    double axsPriceChange = data['axie-infinity']['php_24h_change'] ?? 0.0;

    // Update global variables with price change values
    globalEthPriceChange = ethPriceChange;
    globalBtcPriceChange = btcPriceChange;
    globalLtcPriceChange = ltcPriceChange;
    globalXrpPriceChange = xrpPriceChange;
    globalAxsPriceChange = axsPriceChange;
  }
}
