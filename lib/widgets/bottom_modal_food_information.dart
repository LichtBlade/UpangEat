import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:upang_eat/Pages/home.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/bloc/tray_bloc/tray_bloc.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/tray_model.dart';
import 'package:upang_eat/repositories/stall_repository.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';

import '../Pages/stall_information.dart';
import '../bloc/food_bloc/food_bloc.dart';

class BottomModalFoodInformation extends StatefulWidget {
  final FoodModel food;
  final bool isOnHome;
  const BottomModalFoodInformation({super.key, required this.food, this.isOnHome = false});

  @override
  State<BottomModalFoodInformation> createState() =>
      _BottomModalFoodInformationState();
}

class _BottomModalFoodInformationState
    extends State<BottomModalFoodInformation> {
  int _quantity = 1;
  int _price = 0;
  int id = 1; //TODO Change
  bool _isUpdate = false;
  TrayModel _existingTrayItem = const TrayModel(trayId: 0, userId: 0, itemId: 0, quantity: 0);
  @override
  void initState() {
    _price = widget.food.price;
    context.read<TrayBloc>().add(LoadTray(id));
    super.initState();
  }

  void _incrementQuantity() {
    if (_quantity < 99) {
      setState(() {
        _quantity++;
        _price += widget.food.price;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _price -= widget.food.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrayBloc, TrayState>(
  listener: (context, state) {
    if (state is TrayLoaded){
      for (var trayItem in state.trays) {
        if (trayItem.itemId == widget.food.foodItemId) {
          // If a match is found, update the state
          setState(() {
            _isUpdate = true;
            _quantity = trayItem.quantity;
            _existingTrayItem = trayItem;
            _price = widget.food.price * _quantity;

          });
          break; // Exit the loop after finding a match
        }
      }
    }
  },
  child: BlocBuilder<TrayBloc, TrayState>(
  builder: (context, state) {
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
                              IconButton(
                                onPressed: _decrementQuantity,
                                iconSize: 16,
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xFFF0F0F0),
                                ),
                                color: Colors.black,
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                                icon: const Icon(
                                  Icons.remove,
                                ),
                              ),
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
                              IconButton(
                                onPressed: _incrementQuantity,
                                icon: const Icon(Icons.add),
                                color: Colors.black,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                                iconSize: 16,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
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
                            price: _price,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          _AddToTrayButton(
                            food: widget.food,
                            quantity: _quantity,
                            isUpdate: _isUpdate,
                            existingTrayItem: _existingTrayItem,
                            isOnHome: widget.isOnHome,
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
  },
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
  final bool isUpdate;
  final TrayModel existingTrayItem;
  final bool isOnHome;
  const _AddToTrayButton(
      {super.key, required this.food, required this.quantity, required this.isUpdate, required this.existingTrayItem, required this.isOnHome});

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if(isUpdate)
              OutlinedButton(onPressed: (){
              showDialog(context: context, builder: (context) {
                return _DeleteDialog(title: "Delete Item", message: "Are you sure you want to delete ${food.itemName}?", onDelete: () {
                  context.read<TrayBloc>().add(DeleteTray(existingTrayItem.trayId));
                });
              });
            }, child: const Text("Remove"))
            else
              const SizedBox(),
            const SizedBox(width: 8,),
            FilledButton(
              onPressed: () async {
                final snackBar = SnackBar(
                  dismissDirection: DismissDirection.vertical,
                  duration: const Duration(seconds: 4),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 180,
                      right: 20,
                      left: 20),
                  behavior: SnackBarBehavior.floating,
                  content: AwesomeSnackbarContent(
                    title: "All set!",
                    message: "We've updated the quantity of ${food.itemName} in your tray.",
                    contentType: ContentType.success,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                );
        
                if (isUpdate) {
                  context.read<TrayBloc>().add(UpdateTray(existingTrayItem.trayId, TrayModel(trayId: existingTrayItem.trayId, userId: existingTrayItem.userId, itemId: existingTrayItem.itemId, quantity: quantity)));

                } else {
                  context.read<TrayBloc>().add(CreateTray(food.foodItemId, quantity));
                  
                }
                Navigator.pop(context);
                if (isOnHome){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => StallInformation(stall: widget.stall)));
                }
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
              child: isUpdate ? const Text("Update Quantity") : const Text("Add To Tray")),
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
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            onDelete();

          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}