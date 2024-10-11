import 'package:flutter/material.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/widgets/seller_center_widgets/food_card.dart';

class ProductListDisplay extends StatefulWidget {

  final List<FoodModel> foods;

  const ProductListDisplay({super.key, required this.foods});

  @override
  State<ProductListDisplay> createState() => _ProductListDisplayState();
}

class _ProductListDisplayState extends State<ProductListDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.foods.length,
      itemBuilder: (context, index) {
        final food = widget.foods[index];
        return Container(
          color: Colors.lightGreenAccent,
          child: FoodCard(
            food: food,
          ),
        );
      },
    );
  }
}
