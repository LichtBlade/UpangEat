import 'package:flutter/material.dart';
import 'package:upang_eat/pages/user_login.dart';

import '../../Pages/wallet_pages/wallet.dart';

class SellerDrawer extends StatefulWidget {
  const SellerDrawer({super.key});

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.lightGreen),
            padding: const EdgeInsets.only(top: 28.0),
            child: Column(children: [Image.asset("assets/FlameCoin.png", width: 64, height: 64,), const Text("Upang Eats", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),)],),
          ),
          ListTile(
            title: const Text("Home"),
            selected: true,
            selectedTileColor: Colors.black12,
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

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wallet(),
                  ),
                );
              });
            },
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              setState(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const UserLogin()),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
