import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Pages/home.dart';
import 'package:upang_eat/Pages/notifications.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Pages/tray.dart';
import 'package:upang_eat/Pages/wallet.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';
// stall_bloc
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';
// login_bloc
import 'package:upang_eat/widgets/user_login.dart';
import 'package:upang_eat/bloc/login_bloc/login_bloc.dart';
import 'package:upang_eat/repositories/auth_repository_impl.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedBottomNavIndex = 0;

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
    // MultiBloc for stall_bloc and login_bloc
    return MultiBlocProvider(
      providers: [
        // stall_bloc
        BlocProvider(
          create: (context) => StallBloc(StallRepositoryImpl()),
        ),
        // login_bloc
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: AuthRepositoryImpl(baseUrl: 'http://localhost:3000')),
        ),
      ],
      child: MaterialApp(
        title: "Upang Eat",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        // route for login
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: Text(_appBarTitle[_selectedBottomNavIndex]),
                  leading: Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                ),
                drawer: const CustomDrawer(),
                body: _pages[_selectedBottomNavIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_sharp), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.food_bank_sharp), label: "Stalls"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications_sharp),
                        label: "Notifications"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.fastfood_sharp), label: "Tray"),
                  ],
                  currentIndex: _selectedBottomNavIndex,
                  onTap: (value) {
                    setState(() {
                      _selectedBottomNavIndex = value;
                    });
                  },
                ),
              ),
        },
      ),
    );
  }
}
