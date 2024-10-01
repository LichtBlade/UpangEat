import 'package:flutter/material.dart';

import '../models/food_model.dart';

class HomeMealCard extends StatefulWidget {
  final FoodModel food;
  final bool isShowStallName;
  const HomeMealCard({super.key, required this.food, required this.isShowStallName});

  @override
  State<HomeMealCard> createState() => _HomeMealCardState();
}

class _HomeMealCardState extends State<HomeMealCard> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 360,
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14.0),
                    bottomLeft: Radius.circular(14.0)),
                child: Image.asset(
                  widget.food.imageUrl! != "" ? widget.food.imageUrl! : "assets/stalls/profiles/1.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.food.itemName,
                      style: const TextStyle(fontWeight: FontWeight.bold, ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(widget.food.description!, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(child: Text("₱${widget.food.price}", style: const TextStyle(fontWeight: FontWeight.w600),)),
                        ),
                        if (widget.food.stallName != "" && widget.isShowStallName)
                          Expanded(
                              flex: 2,
                              child: Text(
                                widget.food.stallName!,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, color: Color.fromARGB(120, 0, 0, 0)),
                              )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
