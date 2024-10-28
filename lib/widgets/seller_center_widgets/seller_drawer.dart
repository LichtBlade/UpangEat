import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/pages/seller_center/analytics.dart';
import 'package:upang_eat/pages/seller_center/stall_profile.dart';
import 'package:upang_eat/pages/user_login.dart';
import 'package:upang_eat/user_data.dart';

import '../../Pages/wallet_pages/wallet.dart';
import '../../bloc/analytic_food_bloc/analytic_food_bloc.dart';
import '../../models/food_analytic_model.dart';

class SellerDrawer extends StatefulWidget {
  const SellerDrawer({super.key});

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {
  List<FoodAnalyticModel> foodAnalytics = [];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 222, 25, 67),
            ),
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/upangeats.png",
                  width: 98,
                  height: 98,
                  color: Colors.white,
                ),
                const Text(
                  "Upang Eats",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                )
              ],
            ),
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
            title: const Text("Analytics"),
            onTap: () {
              setState(() {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Analytics(),
                  ),
                );
              });
            },
          ),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              setState(() {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StallProfile(),
                  ),
                );
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
