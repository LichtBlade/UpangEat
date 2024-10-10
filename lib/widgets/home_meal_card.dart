import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:upang_eat/widgets/bottom_modal_food_information.dart';

import '../models/food_model.dart';

class HomeMealCard extends StatefulWidget {
  final FoodModel food;
  final bool isShowStallName;
  final bool isOnHome;
  const HomeMealCard(
      {super.key, required this.food, required this.isShowStallName, this.isOnHome = false});

  @override
  State<HomeMealCard> createState() => _HomeMealCardState();
}

class _HomeMealCardState extends State<HomeMealCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(context: context, builder: (context) => BottomModalFoodInformation(food: widget.food, isOnHome: widget.isOnHome,));

      },
      child: Card.filled(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SizedBox(
          width: 360,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Image(
                imageUrl: widget.food.imageUrl!,
              ),
              _Contents(
                stallName: widget.food.stallName!,
                isShowStallName: widget.isShowStallName,
                description: widget.food.description!,
                itemName: widget.food.itemName,
                price: widget.food.price,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String imageUrl;
  const _Image({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14.0), bottomLeft: Radius.circular(14.0)),
        child: Image.asset(
          imageUrl != "" ? imageUrl : "assets/stalls/profiles/1.jpg",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ));
  }
}

class _Contents extends StatelessWidget {
  final String itemName;
  final String description;
  final int price;
  final String stallName;
  final bool isShowStallName;
  const _Contents(
      {super.key,
      required this.itemName,
      required this.description,
      required this.price,
      required this.stallName,
      required this.isShowStallName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              itemName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                      child: Text(
                    "₱$price",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )),
                ),
                if (stallName != "" && isShowStallName)
                  Expanded(
                      flex: 2,
                      child: Text(
                        stallName,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, color: Color.fromARGB(120, 0, 0, 0)),
                      )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

