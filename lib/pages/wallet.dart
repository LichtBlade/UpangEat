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
    backgroundColor: const Color(0xFFDE0F39),
    elevation: 5,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 20),
  );

  @override
  void initState() {
    super.initState();
    // Trigger the loading of transactions when the widget is initialized
    context.read<TransactionBloc>().add(LoadTransaction());
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
                    Container(
                      width: 400,
                      height: 225,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20, left: 40),
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
                                child: const Text('Deposit'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: style_Button,
                                child: const Text('Transfer'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: style_Button,
                                child: const Text('Convert'),
                              ),
                            ],
                          ),
                        ],
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
