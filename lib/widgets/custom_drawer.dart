import 'package:flutter/material.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Pages/wallet.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightGreen),
            child: Text("Drawer Header"),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text("Stalls"),
            onTap: () {
              setState(() {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => const Stalls()));
              });
            },
          ),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text("Wallet"),
            onTap: () {
              setState(() {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => const Wallet()));
              });
            },
          ),
          ListTile(
            title: const Text("Purchase History"),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text("Report A Problem"),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
