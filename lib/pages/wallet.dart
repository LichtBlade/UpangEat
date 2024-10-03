import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/widgets/transaction_card.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import 'package:upang_eat/repositories/transaction_repository.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final coin = "assets/FlameCoin.png";

  final ButtonStyle style_Button = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFDE163D),
    elevation: 5,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 12),
  );

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const LoadTransaction(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Card(

                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      elevation: 16,
                      child: SizedBox(
                        height: 245,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Image.asset(
                                    coin,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(top: 20, right: 40),
                                    child: const Text(
                                      '123456.789',
                                      style: TextStyle(
                                        color: Color(0xFF202020),
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              '87as46eg54a6cv1',
                              style: TextStyle(
                                color: Color(0xFF202020),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: style_Button,
                                  child: const Text('Deposit', style: TextStyle(fontSize: 14),),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: style_Button,
                                  child: const Text('Transfer', style: TextStyle(fontSize: 14),),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: style_Button,
                                  child: const Text('Convert', style: TextStyle(fontSize: 14),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Transaction History',
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 30,
                      ),
                    ),
                    // Use BlocBuilder to display the transaction list
                    BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                        if (state is TransactionLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is TransactionLoaded) {
                          return ListView.builder(
                            itemCount: state.transactions.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final transaction = state.transactions[index];
                              return TransactionCard(
                                transaction: transaction,
                              );
                            },
                          );
                        } else if (state is TransactionError) {
                          return Text("Error loading transactions: ${state.message}");
                        } else {
                          return const Text("No transactions found.");
                        }
                      },
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
