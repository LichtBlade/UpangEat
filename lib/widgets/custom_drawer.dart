import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:upang_eat/pages/purchase_history.dart';
import 'package:upang_eat/pages/user_login.dart';
import 'package:upang_eat/repositories/transaction_repository_impl.dart';
import 'package:upang_eat/user_data.dart';

import '../Pages/wallet_pages/wallet.dart';
import '../models/order_model.dart';

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
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/upang.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode( // Add a color filter
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
                  BlendMode.darken,
                ),
              ),
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
            title: const Text("Stalls"),
            onTap: () {
              setState(() {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => const Stalls()));
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
            title: const Text("Purchase History"),
            onTap: () {
              final filteredOrders = globalOrders.where((order) =>
              order.orderStatus == 'completed' || order.orderStatus == 'cancelled'
              ).toList();
              setState(() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PurchaseHistory(orders:  filteredOrders),
                  ),
                );
              });
            },
          ),

          // ListTile(
          //   title: const Text("Report A Problem"),
          //   onTap: () {
          //     setState(() {
          //       Navigator.pop(context);
          //     });
          //   },
          // ),
          // ListTile(
          //   title: const Text("Settings"),
          //   onTap: () {
          //     setState(() {
          //       Navigator.pop(context);
          //     });
          //   },
          // ),
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