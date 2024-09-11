import 'package:flutter/material.dart';
import 'package:upang_eat/Pages/Home.dart';
import 'package:upang_eat/Pages/Stalls.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Upang Eat",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routes: {
        "/": (context) => const Stalls(),
      },
    );
  }
}
