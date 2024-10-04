import 'package:flutter/material.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/stall_model.dart';

class TrayCard extends StatefulWidget {
  final FoodModel foodtray;
  final Stall stall;

  const TrayCard({
    super.key,
    required this.foodtray,
    required this.stall,
  });

  @override
  TrayCardState createState() => TrayCardState();
}

class TrayCardState extends State<TrayCard> {
  



  
  bool _checkboxValue = false;
  int counter = 0;
  double subtotal = 0.0;

  void onIncrement() {
    setState(() {
      counter++;
      subtotal += widget.foodtray.price;
    });
  }

  void onDecrement() {
    setState(() { 
      if (counter > 0) {
        counter--;
        subtotal -= widget.foodtray.price;
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 150,
          width: 400,
          // color: const Color.fromARGB(255, 221, 199, 134),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                widget.foodtray.imageUrl ?? 'assets/drink.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.foodtray.itemName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.stall.stallName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onDecrement,
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$counter', // Display the counter value
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: onIncrement,
                          icon: const Icon(Icons.add),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'Subtotal: $subtotal', // Display subtotal
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
