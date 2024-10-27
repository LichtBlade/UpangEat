import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/widgets/bottom_modal_food_information.dart';

import '../main.dart';

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
          showCupertinoModalBottomSheet(context: context, builder: (context) =>BottomModalFoodInformation(food: widget.food));
        },
        child: Card.filled(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Column(children: [
              Image.network(widget.food.imageUrl!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover, errorBuilder:
                      (context, error, stackTrace) {
                    return const Text('Error loading image');
                  },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (frame == null) {
                    return Skeletonizer(
                      enabled: true,
                      child: Image.asset("assets/foods/1_1.jpg",
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,),
                    );
                  } else {
                    return child;
                  }
                },),
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
