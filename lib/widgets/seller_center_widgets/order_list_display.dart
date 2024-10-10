// TODO: Remake order list to take items from each list item
import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/order_list.dart';

class OrderListDisplay extends StatefulWidget {
  // The idea here is to just shove a list and the widget builds itself.

  final List<Map<dynamic, dynamic>> items;

  const OrderListDisplay({
    super.key,
    required this.items,
  });

  @override
  State<OrderListDisplay> createState() => _OrderListDisplayState();
}

class _OrderListDisplayState extends State<OrderListDisplay> {
  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: const Color.fromARGB(255, 237, 237, 237),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Top Label
            _OrderCount(length: widget.items.length),
            // List
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return const OrderList();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OrderCount extends StatelessWidget {
  final int length;
  const _OrderCount({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Orders:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$length',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

