import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/transaction_bloc/transaction_bloc.dart';
import '../../widgets/wallet_widgets/transaction_card.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const LoadTransaction(1));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Transaction History"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20,),
              // Use BlocBuilder to display the transaction list
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const CupertinoActivityIndicator();
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
      ),
    );
  }
}
