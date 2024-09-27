import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/custom_list_view_card.dart';
import 'package:upang_eat/widgets/seller_center_widgets/custom_segmented_button.dart';

import '../../widgets/seller_center_widgets/order_list.dart';

class SellerCenterProducts extends StatefulWidget {
  const SellerCenterProducts({super.key});

  @override
  State<SellerCenterProducts> createState() => _SellerCenterProductsState();
}

class _SellerCenterProductsState extends State<SellerCenterProducts> {
  @override
  Widget build(BuildContext context) {
    String popUpVal = 'Complete';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text(popUpVal)),
                    const PopupMenuItem(child: Text('Canceled')),
                  ]),
        ],
      ),
      body: const Column(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 80,
              child: Center(
                child: CustomSegmentedButton(),
              ),
            ),
          ),
          Expanded(
            flex: 6,
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
