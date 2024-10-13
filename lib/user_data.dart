import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/models/user_model.dart';

UserModel? globalUserData;

double globalEthBalance = 0;
String globalWalletEthAddress = '';

String globalUserWallet =
    '0x8e32f7442f65bdb5ea7fe253af3bbc284faaeca10d2634a495b48a0ab2d9ee1d';
String globalSelletWallet =
    '0x391275d70808dbaf71bebb0efbc988e719b93f6bb145d1635254e024496e3c36';

List<OrderModel> globalOrders = [];