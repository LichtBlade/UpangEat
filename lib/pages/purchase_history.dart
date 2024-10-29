import 'package:flutter/material.dart';

import '../models/order_model.dart';

class PurchaseHistory extends StatefulWidget {
  final List<OrderModel> orders;
  const PurchaseHistory({super.key, required this.orders});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Purchase History"),
        ),
        body: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 8.0), itemCount: widget.orders.length, scrollDirection: Axis.vertical, itemBuilder: (context, index) {

          final order = widget.orders[index];
          final Color color = switch(order.orderStatus){
            "pending" => Colors.grey,
            "accepted" => Colors.blue,
            "ready" => Colors.green,
            "completed" => Colors.green,
            "refunded" => Colors.red,
            "cancelled" => Colors.red,
            _ => Colors.black
          };

          return Card.filled(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      "Order #${order.orderId}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(order.orderDate!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,)),
                        const SizedBox(width: 8,),
                        Text(order.orderStatus!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),),
                      ],
                    )
                  ]),
                  Column(
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.items.length,
                          itemBuilder: (context, index) {
                        final item = order.items[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${item.quantity}x ${item.itemName}"),
                            Text("₱ ${item.subtotal}"),
                            // if (item.imageUrl != null)
                            //   Image.network(
                            //     item.imageUrl!,
                            //     height: 50,
                            //     width: 50,
                            //     errorBuilder: (context, error, stackTrace) {
                            //       return const SizedBox(
                            //         height: 50,
                            //         width: 50,
                            //         child: Icon(Icons.error),
                            //       );
                            //     },
                            //   ),
                          ],
                        );
                      },
                    ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [const Text("Total", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)), Text("₱ ${order.totalAmount}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
