import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:upang_eat/models/food_model.dart';

void bottomModalFoodInformation(BuildContext context, FoodModel food) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: 600,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                food.imageUrl! != "" ? food.imageUrl! : "assets/stalls/profiles/1.jpg",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: -10,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Title(foodName: food.itemName, stallName: food.stallName!,),
                          const _Quantity(),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      _Description(description: food.description!,),
                      Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _Price(price: food.price,),
                              const _BookmarkAndAddToTray(),
                            ],
                          )),
                      const SizedBox(height: 10,)

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class _Title extends StatelessWidget {
  final String stallName;
  final String foodName;
  const _Title({super.key, required this.stallName, required this.foodName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (stallName.isNotEmpty)
          GestureDetector(
            onTap: () {

            },
            child: Text(
              stallName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(200, 0, 0, 0)),
            ),
          ),
          Text(
            foodName,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.add),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent),
            )),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 50,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 3.0, bottom: 14.0)),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.remove),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent),
            )),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  final String description;
  const _Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class _Price extends StatelessWidget {
  final int price;
  const _Price({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Price",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        Text("₱$price", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _BookmarkAndAddToTray extends StatelessWidget {
  const _BookmarkAndAddToTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton.outlined(
            onPressed: () {},
            color: Colors.redAccent,
            icon: const Icon(Icons.bookmark_border),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent),
            )),
        const SizedBox(width: 8,),
        FilledButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.only(left: 30, right: 30, top: 18, bottom: 18),
              ),
            ),
            onPressed: () {},
            child: const Text("Add To Tray"))
      ],
    );
  }
}