import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final List<String> coins = [
    "assets/FlameCoin.png",
    "assets/FlameCoin1.png",
    "assets/FlameCoin2.png",
    "assets/FlameCoin3.png",
    "assets/FlameCoin4.png",
    "assets/FlameCoin5.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
    "assets/drink.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet"),),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          final coin = coins[index];
          return Image.asset(coin);
        },
        itemCount: coins.length,),
      ),
    );
  }
}
