import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.white,
              elevation: 16,
              child: SizedBox(
                width: 380,
                height: 245,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          child: Column(
                            children: [
                              const Text(
                                '123456.789',
                                style: TextStyle(
                                  color: Color(0xFF202020),
                                  fontSize: 30,
                                ),
                              ),
                              TextButton.icon(
                                label: const Text('87as46eg54a6cv1'),
                                icon: const Icon(
                                  Icons.copy,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Clipboard.setData(const ClipboardData(text: "87as46eg54a6cv1"));

                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: styleButton,
                              child: const Text(
                                'Deposit',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12,),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: styleButton,
                              child: const Text(
                                'Transfer',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}


class _Buttons extends StatelessWidget {
  const _Buttons({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: styleButton,
              child: const Text(
                'Deposit',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: styleButton,
              child: const Text(
                'Transfer',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final ButtonStyle styleButton = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFDE163D),
  elevation: 5,
  foregroundColor: Colors.white,
  textStyle: const TextStyle(fontSize: 12),
);