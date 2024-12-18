import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/food_model.dart';

import '../../bloc/food_bloc/food_bloc.dart';
import '../../main.dart';
import '../../pages/seller_center/seller_center_product_form.dart';

class FoodCard extends StatefulWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                    widget.food.imageUrl != null
                        ? widget.food.imageUrl!
                        : "${IpAddress.ipAddress}/uploads/${widget.food.stallId}_${widget.food.foodItemId}.jpg", 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Error Loading image'),);
                }),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          widget.food.itemName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        '₱${widget.food.price}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.food.isAvailable ? "Available" : "Unavailable",
                        style: TextStyle(
                            color: widget.food.isAvailable
                                ? Colors.green
                                : Colors.black26),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SellerCenterProductForm(
                                  stallId: widget.food.stallId,
                                  isUpdate: true,
                                  food: widget.food,
                                ),
                              ),
                            ),
                            child: const ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () => context.read<FoodBloc>().add(
                                DeleteFood(widget.food.foodItemId,
                                    widget.food.stallId)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  // Column( // Wrap the Switch in a Row
                  //   children: [
                  //     Text(
                  //       _isActive ? 'Available' : 'Unavailable', // Indicate the state
                  //       style: TextStyle(
                  //         color: _isActive ? Colors.green : Colors.red, // Optional: Color-code the text
                  //       ),
                  //     ),
                  //     Switch(
                  //       value: _isActive,
                  //       onChanged: (bool value) {
                  //         setState(() {
                  //           _isActive = value;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
