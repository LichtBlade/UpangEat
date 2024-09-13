import 'package:flutter/material.dart';
import 'package:upang_eat/Pages/Home.dart';
import 'package:upang_eat/Pages/Notifications.dart';
import 'package:upang_eat/Pages/Stalls.dart';
import 'package:upang_eat/Pages/Tray.dart';
import 'package:upang_eat/Pages/Wallet.dart';
import 'package:upang_eat/Widgets/CustomDrawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedBottomNavIndex = 3;

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
    return MaterialApp(
      title: "Upang Eat",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
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
                icon: Icon(Icons.notifications_sharp), label: "Notifications"),
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
    );
  }
}
