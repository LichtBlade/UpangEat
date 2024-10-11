// ignore_for_file: public_member_api_docs, sort_constructors_first

// Food displayed here
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/pages/seller_center/seller_center_product_form.dart';
import 'package:upang_eat/widgets/seller_center_widgets/product_list_display.dart';

class SellerCenterProducts extends StatefulWidget {
  final int stallId;

  const SellerCenterProducts({
    super.key,
    required this.stallId,
  });

  @override
  State<SellerCenterProducts> createState() => _SellerCenterProductsState();
}

class _SellerCenterProductsState extends State<SellerCenterProducts> {
  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(LoadFoodByStallId(widget.stallId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        title: const Text(
          'Boss Sisig',
          style: TextStyle(
            color: Colors.white,
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
                          builder: (context) => SellerCenterProductForm(
                                stallId: widget.stallId,
                              ))),
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
          BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state is FoodLoading) {
                return const CircularProgressIndicator();
              } else if (state is FoodLoaded) {
                final foods = state.foods;
                return foods.isNotEmpty
                    ? Column(
                        children: [
                          // List
                          ProductListDisplay(
                            foods: foods,
                          )
                        ],
                      )
                    : const Center(
                        child: Text('No data'),
                      );
              }
              return const Text('Unexpected Data');
            },
          ),
        ],
      ),
    );
  }
}
