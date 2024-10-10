// TODO: Create stall product list

import 'package:flutter/material.dart';
import 'package:upang_eat/pages/seller_center/seller_center_product_form.dart';
import 'package:upang_eat/widgets/seller_center_widgets/product_list_display.dart';

class SellerCenterProducts extends StatefulWidget {
  const SellerCenterProducts({super.key});

  @override
  State<SellerCenterProducts> createState() => _SellerCenterProductsState();
}

class _SellerCenterProductsState extends State<SellerCenterProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        title: const Center(
          child: Text(
            'Boss Sisig',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SellerCenterProductForm())),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.add_box_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'Add Product',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // List
          const ProductListDisplay()
        ],
      ),
    );
  }
}
