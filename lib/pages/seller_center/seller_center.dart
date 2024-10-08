// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_appbar.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_btn.dart';

enum OrderState { pending, accepted, ready }

Map<OrderState, String> valueString = <OrderState, String>{
  OrderState.pending: 'Pending',
  OrderState.accepted: 'Accepted',
  OrderState.ready: 'Ready'
};

class SellerCenter extends StatefulWidget {
  const SellerCenter({super.key});

  @override
  State<SellerCenter> createState() => _SellerCenterState();
}

class _SellerCenterState extends State<SellerCenter> {
  @override
  Widget build(BuildContext context) {
    OrderState _selectedSegment = OrderState.pending;
    return Scaffold(
      appBar: const SellerCenterAppbar(stallName: 'Food'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SellerCenterBtn(label: 'Products'),
            const Divider(
              height: 14.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                CupertinoSegmentedControl(
                  selectedColor: const Color.fromARGB(255, 222, 15, 57),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  groupValue: _selectedSegment,
                  children: const {
                    
                  },
                  onValueChanged: (OrderState value) {
                    setState(() {
                      _selectedSegment = value;
                    });
                  },
                ),
                const SizedBox(height: 12.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
