import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:upang_eat/models/food_model.dart';

import '../bloc/food_bloc/food_bloc.dart';
import '../bloc/tray_bloc/tray_bloc.dart';
import 'bottom_modal_food_information.dart';

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
  int counter = 0;
  int subtotal = 0;
  @override
  void initState() {
    counter = widget.food.trayQuantity ?? 0;
    subtotal = widget.food.price * counter;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => BottomModalFoodInformation(
                  food: widget.food,
                  isOnTray: true,
                ));
      },
      child: Card.outlined(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                child: Image.asset(
                  widget.food.imageUrl == "" ? "assets/stalls/profiles/1.jpg" : widget.food.imageUrl ?? "assets/stalls/profiles/1.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 220,
                height: 90,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food.itemName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Text(
                          widget.food.stallName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    BlocListener<FoodBloc, FoodState>(
                      listener: (context, state) {
                        if (state is TrayLoaded){
                          // state.trays.
                        }
                      },
                      child: _SubtotalAndQuantity(subtotal: subtotal, counter: counter),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubtotalAndQuantity extends StatelessWidget {
  final int subtotal;
  final int counter;
  const _SubtotalAndQuantity({super.key, required this.subtotal, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₱$subtotal', // Display subtotal
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            'Quantity: $counter', // Display the counter value
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
