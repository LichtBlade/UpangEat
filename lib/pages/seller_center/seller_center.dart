// TODO : Change segmented button into CupertinoSegmentedController
import 'package:flutter/material.dart';
import 'package:upang_eat/pages/seller_center/seller_center_products.dart';
import 'package:upang_eat/widgets/seller_center_widgets/orders_dashboard.dart';
import 'package:upang_eat/widgets/seller_center_widgets/products_card.dart';

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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Dashboard())),
            icon: const Icon(Icons.menu)),
        title: const Text('Seller Center'),
        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
      ),
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
