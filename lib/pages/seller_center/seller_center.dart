// TODO : Change segmented button into CupertinoSegmentedController
import 'package:flutter/material.dart';
import 'package:upang_eat/pages/seller_center/seller_center_products.dart';
import 'package:upang_eat/widgets/seller_center_widgets/orders_dashboard.dart';
import 'package:upang_eat/widgets/seller_center_widgets/products_card.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_appbar.dart';

import '../admin_pages/dashboard.dart';

class SellerCenter extends StatefulWidget {
  const SellerCenter({super.key});

  @override
  State<SellerCenter> createState() => _SellerCenterState();
}

class _SellerCenterState extends State<SellerCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SellerCenterAppbar(stallName: 'Food'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OrdersDashboard(
                numToClaim: 2,
                numToProcess: 2,
                numToReviwew: 1,
                forwardBtnFunc: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SellerCenterProducts()))),
            const Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: ProductsCard(),
            ),
          ],
        ),
      ),
    );
  }
}
