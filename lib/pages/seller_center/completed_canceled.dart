import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../widgets/seller_center_widgets/order_list.dart';

class CompletedCanceled extends StatefulWidget {
  final List<OrderModel> orders;
  final bool isCompleted;
  const CompletedCanceled({super.key, required this.orders, required this.isCompleted});

  @override
  State<CompletedCanceled> createState() => _CompletedCanceledState();
}

class _CompletedCanceledState extends State<CompletedCanceled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget.isCompleted ? const Text("Completed") : const Text("Cancelled"),),
      body: ListView.builder(
        itemCount: widget.orders.length,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemBuilder: (context, index) {
          final order = widget.orders[index];
          return OrderList(order: order, isCompletedOrCancelled: true,);
        },
      ),
    );
  }
}
