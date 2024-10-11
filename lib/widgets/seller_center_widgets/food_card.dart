import 'package:flutter/material.dart';
import 'package:upang_eat/models/food_model.dart';

class FoodCard extends StatefulWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.food.isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        child: SizedBox(
          height: 75,
          width: 75,
          child: Image.asset(widget.food.imageUrl != null
              ? 'assets/foods/1_1.jpg'
              : '${widget.food.imageUrl}'),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.food.itemName,
            style: TextStyle(
                fontSize: widget.food.itemName.length <= 16 ? 16 : 10, // resize based on text length
                fontWeight: FontWeight.bold),
          ),
          Switch(
              value: _isActive,
              onChanged: (bool value) {
                setState(() {
                  _isActive = value;
                });
              })
        ],
      ),
      subtitle: Text(
        '₱${widget.food.price}',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
            ),
          ),
          const PopupMenuItem(
            child: ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: Text('Delete'),
            ),
          ),
        ],
      ),
    );
  }
}
