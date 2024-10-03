import 'package:flutter/material.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/widgets/bottom_modal_food_information.dart';

class MealCardSquare extends StatefulWidget {
  final FoodModel food;
  const MealCardSquare({super.key, required this.food});

  @override
  State<MealCardSquare> createState() => _MealCardSquareState();
}

class _MealCardSquareState extends State<MealCardSquare> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: GestureDetector(
        onTap: () {
          bottomModalFoodInformation(context, widget.food);
        },
        child: Card(
          elevation: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Column(children: [
              Image.asset(widget.food.imageUrl! != "" ? widget.food.imageUrl! : "assets/stalls/profiles/1.jpg",
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover, errorBuilder:
                      (context, error, stackTrace) {
                    return const Text('Error loading image');
                  }),
              Expanded(
                child: SizedBox(
                  width: 130,
                  child:
                  Center(child: Row(
                    children: [
                      Expanded(flex: 2,child: Text(widget.food.itemName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600),)),
                      Expanded(child: Text("₱${widget.food.price}",textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w600),),)
                    ],
                  )),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
