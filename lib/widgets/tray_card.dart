import 'package:flutter/material.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/stall_model.dart';

class TrayCard extends StatefulWidget {
  final FoodModel food;

  const TrayCard({
    super.key,
    required this.food,
  });

  @override
  TrayCardState createState() => TrayCardState();
}

class TrayCardState extends State<TrayCard> {
  bool _checkboxValue = false;
  int counter = 0;
  double subtotal = 1000.0;

  void onIncrement() {
    setState(() {
      counter++;
      subtotal += widget.food.price;
    });
  }

  void onDecrement() {
    setState(() {
      if (counter > 0) {
        counter--;
        subtotal -= widget.food.price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: _checkboxValue,
            onChanged: (value) {
              setState(() {
                _checkboxValue = value!;
              });
            },
          ),
          Image.asset(
            // widget.food.imageUrl ??
                'assets/foods/1_1.jpg',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 210,
                child: Text(
                  widget.food.itemName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                width: 210,
                child: Text(
                  widget.food.stallName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onDecrement,
                    iconSize: 14,
                    icon: const Icon(Icons.remove,),
                  ),
                  Text(
                    '$counter', // Display the counter value
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: onIncrement,
                    icon: const Icon(Icons.add),
                    iconSize: 14,
                  ),
                  Text(
                    'Subtotal: $subtotal', // Display subtotal
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8.0,)
                ],
              ),

            ],
          ),

        ],

      ),
    );
  }
}
