import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/models/user_model.dart';

UserModel? globalUserData;

double globalEthBalance = 0;
double globalEthPrice = 0;
String globalWalletEthAddress = '0x4a3d28fa3942570d0f3880ed75970f3c28258e7b5e92c4213caf1d4c1dcfc4ea';

String globalPrivateKey = '0x4a3d28fa3942570d0f3880ed75970f3c28258e7b5e92c4213caf1d4c1dcfc4ea';

List<OrderModel> globalOrders = [];
