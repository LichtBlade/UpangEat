import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/models/user_model.dart';

UserModel? globalUserData;

double globalEthBalance = 0;
double globalEthPrice = 0;
String globalWalletEthAddress = '';

String globalPrivateKey = '';

List<OrderModel> globalOrders = [];
