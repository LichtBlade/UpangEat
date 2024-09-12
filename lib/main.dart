import 'package:flutter/material.dart';
import 'package:upang_eat/Pages/Home.dart';
import 'package:upang_eat/Pages/Stalls.dart';

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
        ),
        body: _pages[_selectedBottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_sharp), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank_sharp), label: "Stalls"),
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
