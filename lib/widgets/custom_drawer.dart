import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Material for Colors
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Pages/wallet_pages/wallet.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Set the height to 600
      decoration: const BoxDecoration(
        color: CupertinoColors.white, // Set background color
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded corners
      ),
      child: CupertinoScrollbar(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Menu",
                  style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 34),
                ),
              ),
              const SizedBox(height: 10),
              _MenuItem(
                title: "Home",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _MenuItem(
                title: "Stalls",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const Stalls()),
                  );
                },
              ),
              _MenuItem(
                title: "Profile",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _MenuItem(
                title: "Wallet",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const Wallet()),
                  );
                },
              ),
              _MenuItem(
                title: "Purchase History",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _MenuItem(
                title: "Report A Problem",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _MenuItem(
                title: "Settings",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MenuItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      onPressed: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title),
      ),
    );
  }
}
