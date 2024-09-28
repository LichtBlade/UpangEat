import 'package:flutter/material.dart';

class OrderItemCard extends StatefulWidget {
  final String image;
  final String productName;
  final String quantity;

  const OrderItemCard(
      {super.key,
      required this.image,
      required this.productName,
      required this.quantity});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  String image = 'assets/steak.jpg';
  String productName = 'Karne';
  String quantity = '2';

  @override
  void initState() {
    super.initState();

    image = widget.image;
    productName = widget.productName;
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              width: 100,
              child: Image.asset(
                image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(productName),
                Text(quantity),
              ],
            ),
          )
        ],
      ),
    );
  }
}
