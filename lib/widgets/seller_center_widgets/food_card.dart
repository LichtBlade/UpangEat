import 'package:flutter/material.dart';

class FoodCard extends StatefulWidget {
  final String foodName;
  final int foodPrice;

  const FoodCard({super.key, required this.foodName, required this.foodPrice});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        child: SizedBox(
          height: 75,
          width: 75,
          child: Image.asset('assets/foods/1_1.jpg'),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.foodName),
          Switch(
              value: _isActive,
              onChanged: (bool value) {
                setState(() {
                  _isActive = value;
                });
              })
        ],
      ),
      subtitle: Text('${widget.foodPrice}'),
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
