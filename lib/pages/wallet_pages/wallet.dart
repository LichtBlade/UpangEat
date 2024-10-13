import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:upang_eat/pages/wallet_pages/transaction_history.dart';
import 'package:upang_eat/user_data.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import '../../widgets/wallet_widgets/send_dialog.dart';
import '../../widgets/wallet_widgets/token_card.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final coin = "assets/FlameCoin.png";
  final ethImg = "assets/ethSign.png";
  final sendIcon = "assets/wallets/send.png";
  final depositIcon = "assets/wallets/deposit.png";
  final historyIcon = "assets/wallets/history.png";

  // Price
  double ethPrice = 0.0;
  double btcPrice = 0.0;
  double ltcPrice = 0.0;
  double xrpPrice = 0.0;
  double axsPrice = 0.0;

  // Price change
  double axsPriceChange = 0.0;
  double ethPriceChange = 0.0;
  double btcPriceChange = 0.0;
  double ltcPriceChange = 0.0;
  double xrpPriceChange = 0.0;

  double currentEthBalance = 0.0;
  double _globalEthBalance = globalEthBalance;

  String walletAddress = globalWalletEthAddress;
  void _showSendDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SendDialog(
          onSend: (amount) {
            // Handle the send logic here
            print("Sending $amount");
          },
        );
      },
    );
  }

  Future<void> _fetchTokenPrices() async {
    const String apiUrl =
        "https://api.coingecko.com/api/v3/simple/price?ids=ethereum,bitcoin,litecoin,ripple,axie-infinity&vs_currencies=php&include_24hr_change=true"; // Include 24hr change

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          ethPrice = data['ethereum']['php'] != null
              ? (data['ethereum']['php'] is int
                  ? (data['ethereum']['php'] as int).toDouble()
                  : data['ethereum']['php'])
              : 0.0;
          btcPrice = data['bitcoin']['php'] != null
              ? (data['bitcoin']['php'] is int
                  ? (data['bitcoin']['php'] as int).toDouble()
                  : data['bitcoin']['php'])
              : 0.0;
          ltcPrice = data['litecoin']['php'] != null
              ? (data['litecoin']['php'] is int
                  ? (data['litecoin']['php'] as int).toDouble()
                  : data['litecoin']['php'])
              : 0.0;
          xrpPrice = data['ripple']['php'] != null
              ? (data['ripple']['php'] is int
                  ? (data['ripple']['php'] as int).toDouble()
                  : data['ripple']['php'])
              : 0.0;
          axsPrice = data['axie-infinity']['php'] != null
              ? (data['axie-infinity']['php'] is int
                  ? (data['axie-infinity']['php'] as int).toDouble()
                  : data['axie-infinity']['php'])
              : 0.0;

          ethPriceChange = data['ethereum']['php_24h_change'] ?? 0.0;
          btcPriceChange = data['bitcoin']['php_24h_change'] ?? 0.0;
          ltcPriceChange = data['litecoin']['php_24h_change'] ?? 0.0;
          xrpPriceChange = data['ripple']['php_24h_change'] ?? 0.0;
          axsPriceChange = data['axie-infinity']['php_24h_change'] ?? 0.0;

          globalEthPrice = ethPrice;
        });
      } else {
        print("Failed to load token prices.");
      }
    } catch (error) {
      print("Error fetching token prices: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTokenPrices(); // Fetch token prices when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Your existing Card widget
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 380,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Image.asset(
                              ethImg,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _globalEthBalance.toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Color(0xFF202020),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: walletAddress));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.copy,
                                        size: 18,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          walletAddress,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Icon buttons here...
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Send
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _showSendDialog,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue, // Example color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(sendIcon),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Send',
                        style: TextStyle(fontSize: 16), // Example style
                      ),
                    ],
                  ),

                  // Deposit
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Deposit clicked');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.green, // Example color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(depositIcon),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Deposit',
                        style: TextStyle(fontSize: 16), // Example style
                      ),
                    ],
                  ),

                  // History
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionHistory()),
                          );
                          print('History clicked');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange, // Example color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(historyIcon),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'History',
                        style: TextStyle(fontSize: 16), // Example style
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // List of TokenCards
              SizedBox(
                height: 410,
                child: ListView(
                  children: [
                    TokenCard(
                      tokenImage: ethImg,
                      tokenName: 'ETH',
                      tokenAmount: NumberFormat.currency(
                        locale: 'en_PH',
                        symbol: '₱',
                        decimalDigits: 2,
                      ).format(ethPrice), // Real value of ETH formatted
                      tokenChange: ethPriceChange >= 0
                          ? '+${ethPriceChange.toStringAsFixed(2)}%' // Format with '+' if positive
                          : '${ethPriceChange.toStringAsFixed(2)}%', // Just show as is if negative
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'BTC',
                      tokenAmount: NumberFormat.currency(
                        locale: 'en_PH',
                        symbol: '₱',
                        decimalDigits: 2,
                      ).format(btcPrice),
                      tokenChange: btcPriceChange >= 0
                          ? '+${btcPriceChange.toStringAsFixed(2)}%'
                          : '${btcPriceChange.toStringAsFixed(2)}%',
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'LTC',
                      tokenAmount: NumberFormat.currency(
                        locale: 'en_PH',
                        symbol: '₱',
                        decimalDigits: 2,
                      ).format(ltcPrice),
                      tokenChange: ltcPriceChange >= 0
                          ? '+${ltcPriceChange.toStringAsFixed(2)}%'
                          : '${ltcPriceChange.toStringAsFixed(2)}%',
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'XRP',
                      tokenAmount: NumberFormat.currency(
                        locale: 'en_PH',
                        symbol: '₱',
                        decimalDigits: 2,
                      ).format(xrpPrice),
                      tokenChange: xrpPriceChange >= 0
                          ? '+${xrpPriceChange.toStringAsFixed(2)}%'
                          : '${xrpPriceChange.toStringAsFixed(2)}%',
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'AXS',
                      tokenAmount: NumberFormat.currency(
                        locale: 'en_PH',
                        symbol: '₱',
                        decimalDigits: 2,
                      ).format(axsPrice),
                      tokenChange: axsPriceChange >= 0
                          ? '+${axsPriceChange.toStringAsFixed(2)}%'
                          : '${axsPriceChange.toStringAsFixed(2)}%',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
