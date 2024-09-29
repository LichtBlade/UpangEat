import 'package:flutter/material.dart';

import '../models/food_model.dart';

class HomeMealCard extends StatefulWidget {
  final FoodModel food;
  const HomeMealCard({super.key, required this.food});

  @override
  State<HomeMealCard> createState() => _HomeMealCardState();
}

class _HomeMealCardState extends State<HomeMealCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.food.imageUrl);
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14.0), bottomLeft: Radius.circular(14.0)),
              child: Image.asset(
                "BossSisigProfile.jpg",
                height: 95,
                width: 95,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.itemName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Text(widget.food.description!)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
