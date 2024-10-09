import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/seller_center_appbar.dart';

class SellerCenterProducts extends StatefulWidget {
  const SellerCenterProducts({super.key});

  @override
  State<SellerCenterProducts> createState() => _SellerCenterProductsState();
}

class _SellerCenterProductsState extends State<SellerCenterProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SellerCenterAppbar(stallName: 'Food'),
      body: Column(
        children: [
          // Header label and button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 222, 15, 57),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      // side: BorderSide(color: Colors.transparent, width: 0),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add_box_rounded,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Add Product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
