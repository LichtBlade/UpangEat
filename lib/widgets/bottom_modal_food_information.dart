import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:upang_eat/bloc/tray_bloc/tray_bloc.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/tray_model.dart';

class BottomModalFoodInformation extends StatefulWidget {
  final FoodModel food;
  const BottomModalFoodInformation({super.key, required this.food});

  @override
  State<BottomModalFoodInformation> createState() =>
      _BottomModalFoodInformationState();
}

class _BottomModalFoodInformationState
    extends State<BottomModalFoodInformation> {
  int _quantity = 1;

  void _incrementQuantity() {
    if (_quantity < 99) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                widget.food.imageUrl! != ""
                    ? widget.food.imageUrl!
                    : "assets/stalls/profiles/1.jpg",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Title(
                            foodName: widget.food.itemName,
                            stallName: widget.food.stallName!,
                          ),
                          Row(
                            children: [
                              IconButton.outlined(
                                  onPressed: _incrementQuantity,
                                  icon: const Icon(Icons.add),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.redAccent),
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
                                child: Center(
                                  child: Text(
                                    '$_quantity', // Display the quantity
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconButton.outlined(
                                  onPressed: _decrementQuantity,
                                  icon: const Icon(Icons.remove),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.redAccent),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _Description(
                        description: widget.food.description!,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Price(
                            price: widget.food.price,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          _AddToTrayButton(
                            food: widget.food,
                            quantity: _quantity,
                          )
                        ],
                      )),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
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
              onTap: () {},
              child: Text(
                stallName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
        const Text(
          "Price",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text("₱$price",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _AddToTrayButton extends StatelessWidget {
  final FoodModel food;
  final int quantity;
  const _AddToTrayButton(
      {super.key, required this.food, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.only(left: 30, right: 30, top: 18, bottom: 18),
          ),
        ),
        onPressed: () {
          final snackBar = SnackBar(
            dismissDirection: DismissDirection.vertical,
            duration: const Duration(seconds: 3),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 200,
                right: 20,
                left: 20),
            behavior: SnackBarBehavior.floating,
            content: AwesomeSnackbarContent(
              inMaterialBanner: true,
              title: "Got it!",
              message: "${food.itemName} is waiting for you in your tray",
              contentType: ContentType.success,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          );

          context.read<TrayBloc>().add(CreateTray(food.foodItemId, quantity));

          Navigator.pop(context);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
        child: const Text("Add To Tray"));
  }
}
