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
  String _selectedValue = 'Pending';
  @override
  Widget build(BuildContext context) {
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
                  children: const <String, Widget>{
                    'Pending': Text('Pending'),
                    'Accepted': Text('Accepted'),
                    'Ready': Text('Ready')
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
    switch (_selectedValue) {
      case 'Pending':
        return Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: const Text(
            'Pending',
            style: TextStyle(fontSize: 14),
          ),
        );
      case 'Accepted':
        return Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: const Text(
            'Accepted',
            style: TextStyle(fontSize: 14),
          ),
        );
      case 'Ready':
        return Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: const Text(
            'Ready',
            style: TextStyle(fontSize: 14),
          ),
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
