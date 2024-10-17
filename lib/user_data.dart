import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/models/user_model.dart';

UserModel? globalUserData;

// Wallet Address Global
String globalSellerWallet =
    '0x391275d70808dbaf71bebb0efbc988e719b93f6bb145d1635254e024496e3c36';
String globalUserWallet =
    '0xb92508c3bb483e1f2d48b49f419594fc6d3b8a0f6ee0aa2657a9497d8edc5796';

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
