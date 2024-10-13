import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import '../../main.dart';
import '../../user_data.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletLoading()) {
    on<LoadEthBalance>((event, emit) async {
      emit(WalletLoading());
      try{
        final balance = await sendEther(event.amount, event.accountId);
        emit(WalletBalanceLoaded(balance));
      } catch (error){
        WalletError(error.toString());
      }
    });
  }
}


Future<double> sendEther(double ethAmount, String accountID) async {
  String rpcUrl = IpAddress.rpGanacheUrl; // For Android emulator
  String wsUrl = IpAddress.wsGanacheUrl;

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
    return _fetchWalletGanche(globalPrivateKey);

  } catch (e) {
    print("Transaction failed: $e");
  }
  return 2.0;
}


Future<double> _fetchWalletGanche(String privateKey) async {
  String rpcUrl = IpAddress.rpGanacheUrl; // For Android emulator
  String wsUrl = IpAddress.wsGanacheUrl;

  Web3Client client = Web3Client(
    rpcUrl,
    http.Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    },
  );

  // Obtain credentials from private key
  Credentials credentials =
  await client.credentialsFromPrivateKey(privateKey);

  // Get your Ethereum address from the credentials
  EthereumAddress ownAddress = await credentials.extractAddress();

  // Fetch balance
  EtherAmount balance = await client.getBalance(ownAddress);
  globalEthBalance = balance.getValueInUnit(EtherUnit.ether);
  globalWalletEthAddress = ownAddress.toString();
  print(globalWalletEthAddress); // Convert balance to ETH
  return globalEthBalance;

}