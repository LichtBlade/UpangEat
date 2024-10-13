import 'package:flutter/cupertino.dart';
import 'package:upang_eat/user_data.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

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
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () async {
            String amount = amountController.text.trim();
            String accountID = accountIDController.text.trim();
            if (amount.isNotEmpty && accountID.isNotEmpty) {
              await sendEther(double.parse(amount), accountID);
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

  Future<void> sendEther(double ethAmount, String accountID) async {
    String rpcUrl = "http://10.0.2.2:7545"; // For Android emulator
    String wsUrl = "ws://10.0.2.2:7545/";

    try {
      // Create Web3 client
      Web3Client client = Web3Client(
        rpcUrl,
        http.Client(),
        socketConnector: () {
          return IOWebSocketChannel.connect(wsUrl).cast<String>();
        },
      );

      // Private key (use a test key for Ganache or testnets)
      String privateKey = globalPrivateKey;

      // Obtain credentials from private key
      Credentials credentials =
          await client.credentialsFromPrivateKey(privateKey);

      // Convert accountID to EthereumAddress
      EthereumAddress receiver = EthereumAddress.fromHex(accountID);
      EthereumAddress ownAddress = await credentials.extractAddress();
      print("Own Address: $ownAddress");

      // Convert ethAmount (ETH) to Wei
      BigInt weiAmount =
          BigInt.from(ethAmount * 1e18); // Multiply ETH by 10^18 to get Wei

      // Send Ether transaction
      var result = await client.sendTransaction(
        credentials,
        Transaction(
          from: ownAddress,
          to: receiver,
          value: EtherAmount.inWei(weiAmount), // Use the Wei amount
          gasPrice:
              EtherAmount.inWei(BigInt.from(1000000000)), // Set a gas price
          maxGas: 21000, // Set gas limit
        ),
        chainId: 1337, // Ganache default chain ID
      );

      print("Transaction Hash: $result \n\n Successful Transaction");

      // After sending ETH, fetch the updated balance (optional)
    } catch (e) {
      print("Transaction failed: $e");
    }
  }
}
