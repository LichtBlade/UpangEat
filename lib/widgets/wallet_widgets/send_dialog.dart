import 'package:flutter/cupertino.dart';

class SendDialog extends StatelessWidget {
  final Function(String) onSend;

  const SendDialog({Key? key, required this.onSend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController accountIDController = TextEditingController();

    return CupertinoAlertDialog(
      title: const Text("Send Token"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoTextField(
            controller: amountController,
            placeholder: "Amount",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          CupertinoTextField(
            controller: accountIDController,
            placeholder: "Account ID",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            String amount = amountController.text.trim();
            if (amount.isNotEmpty) {
              onSend(amount);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Send"),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
