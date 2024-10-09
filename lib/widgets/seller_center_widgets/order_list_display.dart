// TODO: Remake order list to take items from each list item
import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/order_list.dart';

class OrderListDisplay extends StatefulWidget {
  // The idea here is to just shove a list and the widget builds itself.

  final List<Map<dynamic, dynamic>> items;
  final double? minHeight;
  final double? maxHeight;

  const OrderListDisplay({
    super.key,
    required this.items,
    this.minHeight,
    this.maxHeight,
  });

  @override
  State<OrderListDisplay> createState() => _OrderListDisplayState();
}

class _OrderListDisplayState extends State<OrderListDisplay> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6.0),
      elevation: 2,
      color: const Color.fromARGB(255, 209, 209, 209),
      child: Column(
        children: [
          // Top Label
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                          '${widget.items.length}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          // List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: widget.minHeight == null ? 250 : widget.minHeight!,
                maxHeight: widget.maxHeight == null ? 500 : widget.maxHeight!,
              ),
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return const OrderList();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
