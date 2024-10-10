import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/food_model.dart';

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
    counter = widget.food.trayQuantity ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    counter = widget.food.trayQuantity ?? -5;
    subtotal = widget.food.price * counter;

    void showDeleteDialog() {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return _DeleteDialog(
            title: "Delete Item",
            message: "Are you sure you want to delete ${widget.food.itemName}?",
            onDelete: () {
              context.read<TrayBloc>().add(DeleteTray(widget.food.trayId!));
            },
          );
        },
      );
    }

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
          showDeleteDialog();
        }
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              widget.food.imageUrl == ""
                  ? "assets/stalls/profiles/1.jpg"
                  : widget.food.imageUrl ?? "assets/stalls/profiles/1.jpg",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 220,
              height: 90,
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
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Text(
                        widget.food.stallName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
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
                          GestureDetector(
                            child: CupertinoButton(
                              onPressed: onDecrement,
                              padding: EdgeInsets.zero,
                              child: const Icon(
                                CupertinoIcons.minus,
                                size: 14,
                              ),
                            ),
                            onLongPress: () {
                              showDeleteDialog();
                            },
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
                          CupertinoButton(
                            onPressed: onIncrement,
                            padding: EdgeInsets.zero,
                            child: const Icon(CupertinoIcons.add, size: 14),
                          ),
                          const SizedBox(width: 12,)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
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

  const _DeleteDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
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
