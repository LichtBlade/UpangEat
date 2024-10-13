import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:upang_eat/models/order_model.dart';

class OrderStatus extends StatefulWidget {
  final List<OrderModel> orders;
  const OrderStatus({super.key, required this.orders});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Status"),
        ),
        body: widget.orders.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                scrollDirection: Axis.vertical,
                itemCount: widget.orders.length,
                itemBuilder: (context, index) {
                  final order = widget.orders[index];
                  final Color color = switch (order.orderStatus) { "pending" => Colors.grey, "accepted" => Colors.blue, "ready" => Colors.green, "completed" => Colors.green, "refunded" => Colors.red, _ => Colors.black };

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
                            Text(
                              order.orderStatus!,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
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
                                      children: [Text("${item.quantity}x ${item.itemName}"), Text("₱ ${item.subtotal}")],
                                    );
                                  }),
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
                })
            : Center(
                child: Image.asset(
                  "assets/mingming.png",
                ),
              ));
  }
}
