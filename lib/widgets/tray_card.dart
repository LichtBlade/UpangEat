import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/stall_model.dart';

import '../bloc/tray_bloc/tray_bloc.dart';

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
    subtotal = widget.food.price;
    counter = widget.food.trayQuantity ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onIncrement() {
      setState(() {
        if (counter < 99) {
          counter++;
          subtotal += widget.food.price;
        }
      });
    }

    void onDecrement() {
      setState(() {
        if (counter > 1) {
          counter--;
          subtotal -= widget.food.price;
        } else {
          showDialog(context: context, builder: (context) {
            return _DeleteDialog(title: "Delete Item", message: "Are you sure you want to delete ${widget.food.itemName}?", onDelete: () {
              context.read<TrayBloc>().add(DeleteTray(widget.food.trayId!));

            });
          });
        }
      });
    }

    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
              child: Image.asset(
                widget.food.imageUrl == ""
                    ? "assets/stalls/profiles/1.jpg"
                    : widget.food.imageUrl ?? "assets/stalls/profiles/1.jpg",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 230,
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      widget.food.stallName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₱$subtotal', // Display subtotal
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onDecrement,
                          iconSize: 14,
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFF0F0F0),
                          ),
                          constraints: const BoxConstraints(
                            maxWidth: 30, // Set a maximum width
                            maxHeight: 30, // Set a maximum height
                          ),
                          icon: const Icon(
                            Icons.remove,
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          '$counter', // Display the counter value
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8,),
                        IconButton(
                          onPressed: onIncrement,
                          icon: const Icon(Icons.add),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          constraints: const BoxConstraints(
                            maxWidth: 30, // Set a maximum width
                            maxHeight: 30, // Set a maximum height
                          ),
                          iconSize: 14,
                        ),
                        const SizedBox(width: 12,)

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeleteDialog extends StatelessWidget {
  final String title;
  final String message;

  final VoidCallback onDelete;

  const _DeleteDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onDelete();

          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
