import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/custom_list_view_card.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_appbar.dart';

import '../../widgets/seller_center_widgets/order_list.dart';

class SellerCenterProducts extends StatefulWidget {
  const SellerCenterProducts({super.key});

  @override
  State<SellerCenterProducts> createState() => _SellerCenterProductsState();
}

class _SellerCenterProductsState extends State<SellerCenterProducts> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: SellerCenterAppbar(stallName: 'Food'),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Center(
              child: Icon(Icons.warning),
            ),
          ),
          Expanded(
            child: CustomListViewCard(
              itemCount: 5,
              item: OrderList(),
            ),
          )
        ],
      ),
    );
  }
}
