import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/models/user_model.dart';

UserModel? globalUserData;

// Wallet Address Global
String globalSellerWallet =
    '0x8e32f7442f65bdb5ea7fe253af3bbc284faaeca10d2634a495b48a0ab2d9ee1d';
String globalUserWallet =
    '0xcd72e17e23b55819612cb4a79fd1eb3634802c28d912c6c76c612e65cc550827';

double globalEthBalance = 0;
double globalEthPrice = 0;
double ethAmount = 0.0;

String globalWalletEthAddress = '';
String globalPaymentEth = "";
String globalPrivateKey = '';

List<OrderModel> globalOrders = [];

double globalBtcPrice = 0.0;
double globalLtcPrice = 0.0;
double globalXrpPrice = 0.0;
double globalAxsPrice = 0.0;

double globalEthPriceChange = 0.0;
double globalBtcPriceChange = 0.0;
double globalLtcPriceChange = 0.0;
double globalXrpPriceChange = 0.0;
double globalAxsPriceChange = 0.0;
