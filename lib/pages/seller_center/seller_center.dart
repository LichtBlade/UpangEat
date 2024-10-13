// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/user_model.dart';
import 'package:upang_eat/pages/seller_center/seller_center_products.dart';
import 'package:upang_eat/user_data.dart';
import 'package:upang_eat/widgets/seller_center_widgets/order_list_display.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_appbar.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_btn.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_drawer.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/order_bloc/order_bloc.dart';
import '../../widgets/seller_center_widgets/order_list.dart';


class SellerCenter extends StatefulWidget {
  const SellerCenter({super.key});

  @override
  State<SellerCenter> createState() => _SellerCenterState();
}

class _SellerCenterState extends State<SellerCenter> {
  UserModel? userData = const UserModel(userId: 0, firstName: "firstName", lastName: "lastName", email: "email");
  String _selectedValue = 'pending';


  @override
  void initState() {
    context.read<LoginBloc>().add(LoadUserData());
    print("Stall IDD: ${globalUserData?.stallId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          print("UserLoaded");
          print(globalUserData);
          userData = globalUserData;
          context.read<OrderBloc>().add(StallFetchOrder(globalUserData?.stallId ?? 0));

        }
      },
      child: Scaffold(
        appBar: SellerCenterAppbar(stallName: globalUserData?.stallName ?? ""),
        drawer: const SellerDrawer(),
        body: RefreshIndicator(
          onRefresh: ()async {
            context.read<OrderBloc>().add(StallFetchOrder(globalUserData?.stallId ?? 0));
          },
          child: Stack(children: [
            Positioned(
              top: 8,
              right: 16,
              left: 16,
              child: SellerCenterBtn(
                label: 'Products',
                onPressed: () {
                  print("User Data: $userData");
                  print("Stall ID: ${userData?.stallId}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerCenterProducts(stallId: userData?.stallId ?? 0,)));
                },
              ),
            ),
            Positioned(
              top: 68,
              right: 8,
              left: 8,
              child: CupertinoSegmentedControl(
                children: const {
                  "pending": Text("Pending"),
                  "accepted": Text("Accepted"),
                  "ready": Text("Ready"),
                },
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                borderColor: const Color.fromARGB(255, 222, 25, 67),
                selectedColor: const Color.fromARGB(255, 222, 25, 67),
                onValueChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                groupValue: _selectedValue,
              ),
            ),
            Positioned(top: 128,
                right: 0,
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {

                      if (state is OrderLoading){
                        print("Order Loading");
                        return const Center(child: CircularProgressIndicator(),);
                      } else if (state is OrderLoaded){
                        final orders = state.order;
                        globalOrders = orders;
                        final filteredOrders = orders.where((order) => order.orderStatus == _selectedValue).toList();
                        print("Order Loaded: $orders");
                        return Column(
                          children: [
                            Card.filled(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Orders:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),), Text("${filteredOrders.length}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)],),
                            ),),
                            Expanded(
                              child: ListView.builder(
                                itemCount: filteredOrders.length,
                                itemBuilder: (context, index) {
                                  final order = filteredOrders[index];
                                  return OrderList(order: order,);
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (state is OrderError){
                        return Text("Error: ${state.message}");
                      } else {
                        return const Text("Unexpected state}");

                      }


                    },
                  ),
                )),

          ]),
        ),
      ),
    );
  }
}
