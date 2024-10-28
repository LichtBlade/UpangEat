import 'package:flutter/material.dart';
import 'package:upang_eat/user_data.dart';

class StallProfile extends StatefulWidget {
  const StallProfile({super.key});

  @override
  State<StallProfile> createState() => _StallProfileState();
}

class _StallProfileState extends State<StallProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 222, 15, 57),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
                Navigator.pop(context);
            },
            color: Colors.white,
          )),
    );
  }
}
