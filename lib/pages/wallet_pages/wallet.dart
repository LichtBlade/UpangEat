import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:upang_eat/pages/wallet_pages/transaction_history.dart';
import '../../widgets/wallet_widgets/send_dialog.dart';
import '../../widgets/wallet_widgets/token_card.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final coin = "assets/FlameCoin.png";
  final sendIcon = "assets/wallets/send.png";
  final depositIcon = "assets/wallets/deposit.png";
  final historyIcon = "assets/wallets/history.png";

  void _showSendDialog() {
    showCupertinoDialog(
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Wallet"),
      ),
      child: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              // Your existing Card widget
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.3),
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
                              coin,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  '123456.78',
                                  style: TextStyle(
                                    color: Color(0xFF202020),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Clipboard.setData(const ClipboardData(text: "87as46eg54a6cv1"));
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min, // To avoid unnecessary width
                                    children: [
                                      Icon(
                                        CupertinoIcons.doc_on_clipboard,
                                        size: 18,
                                        color: CupertinoColors.activeBlue,
                                      ),
                                      SizedBox(width: 5), // Space between icon and text
                                      Text('87as46eg54a6cv1'),
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
                          decoration: buttonBoxDecoration,
                          child: Center(
                            child: Image.asset(sendIcon),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Send',
                        style: buttonTextStyle,
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
                          decoration: buttonBoxDecoration,
                          child: Center(
                            child: Image.asset(depositIcon),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Deposit',
                        style: buttonTextStyle,
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
                            CupertinoPageRoute(builder: (context) => const TransactionHistory()),
                          );
                          print('History clicked');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          width: 60,
                          decoration: buttonBoxDecoration,
                          child: Center(
                            child: Image.asset(historyIcon),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'History',
                        style: buttonTextStyle,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // List of TokenCards
              SizedBox(
                height: 410,
                child: Column(
                  children: [
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'ETH',
                      tokenAmount: '123456.78',
                      tokenChange: '+1.2%',
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'BTC',
                      tokenAmount: '987654.32',
                      tokenChange: '-0.5%',
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'LTC',
                      tokenAmount: '456789.12',
                      tokenChange: '+3.0%',
                    ),
                    TokenCard(
                      tokenImage: coin,
                      tokenName: 'XRP',
                      tokenAmount: '789123.45',
                      tokenChange: '-1.0%',
                    ),
                    // Add more TokenCard instances as needed
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

final buttonBoxDecoration = BoxDecoration(
  color: CupertinoColors.white,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    BoxShadow(
      color: CupertinoColors.systemGrey.withOpacity(0.2),
      blurRadius: 6,
      offset: const Offset(0, 3),
    ),
  ],
);

const buttonTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Color(0xFF3A3A3A),
);
