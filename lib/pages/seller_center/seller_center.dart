// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upang_eat/pages/seller_center/seller_center_products.dart';
import 'package:upang_eat/widgets/seller_center_widgets/order_list_display.dart';
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
  String _selectedValue = 'Pending';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SellerCenterAppbar(stallName: 'Food'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SellerCenterBtn(
              label: 'Products',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SellerCenterProducts()));
              },
            ),
            const Divider(
              height: 14.0,
              color: Colors.transparent,
            ),
            Column(
              children: [
                CupertinoSegmentedControl(
                  selectedColor: const Color.fromARGB(255, 222, 15, 57),
                  borderColor: Colors.black,
                  children: <String, Widget>{
                    'Pending': Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                            color: _selectedValue == 'Pending'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    'Accepted': Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Accepted',
                        style: TextStyle(
                            color: _selectedValue == 'Accepted'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    'Ready': Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Ready',
                        style: TextStyle(
                            color: _selectedValue == 'Ready'
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  },
                  onValueChanged: (String value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  groupValue: _selectedValue,
                ),
                const SizedBox(height: 12.0),
                _selectPage()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectPage() {
    //placeholder
    List<Map<String, dynamic>> orderItems = [
      {
        'image': 'assets/foods/1_1.jpg',
        'productName': 'Meant',
        'price': 400,
        'quantity': 2
      },
      {
        'image': 'assets/foods/1_1.jpg',
        'productName': 'Sisid',
        'price': 400,
        'quantity': 3
      },
      {
        'image': 'assets/foods/1_1.jpg',
        'productName': 'Stick',
        'price': 400,
        'quantity': 1
      },
    ];

    switch (_selectedValue) {
      case 'Pending':
        return OrderListDisplay(
          items: orderItems,
          minHeight: 250,
          maxHeight: 575,
        );

      case 'Accepted':
        return OrderListDisplay(
          items: orderItems,
          minHeight: 250,
          maxHeight: 575,
        );
      case 'Ready':
        return OrderListDisplay(
          items: orderItems,
          minHeight: 250,
          maxHeight: 575,
        );

      default:
        return Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: const Text(
            'How?',
            style: TextStyle(fontSize: 14),
          ),
        );
    }
  }
}
