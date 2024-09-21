import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/home_meal_card.dart';

class HomeMealCardVerticalList extends StatefulWidget {
  final List<String> foods;
  const HomeMealCardVerticalList({super.key, required this.foods});

  @override
  State<HomeMealCardVerticalList> createState() => _HomeMealCardVerticalListState();
}

class _HomeMealCardVerticalListState extends State<HomeMealCardVerticalList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.foods.length,
        itemBuilder: (context, index) {
          final food = widget.foods[index];
          return HomeMealCard(food: food);
        });
  }
}
