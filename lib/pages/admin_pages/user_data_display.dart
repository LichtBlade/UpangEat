import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataDisplay extends StatefulWidget {
  const UserDataDisplay({super.key});

  @override
  State<UserDataDisplay> createState() => _UserDataDisplayState();
}

class _UserDataDisplayState extends State<UserDataDisplay> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
    // return Scaffold(appBar: AppBar(), body: BlocBuilder<>(builder: builder),);
  }
}
