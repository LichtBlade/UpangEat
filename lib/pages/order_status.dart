import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:upang_eat/models/order_model.dart';

import '../bloc/order_bloc/order_bloc.dart';

class OrderStatus extends StatefulWidget {
  final bool isAllowPending;
  final bool isAllowAccepted;
  final bool isAllowReady;
  final bool isAllowCancelled;
  final bool isAllowCompleted;

  const OrderStatus({super.key, this.isAllowPending = false, this.isAllowAccepted = false, this.isAllowReady = false, this.isAllowCancelled = false, this.isAllowCompleted = false});

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
        body: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Deleted")));
            } else if (state is OrderError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (state is OrderLoaded) {
                final orders = state.order;
                final filteredOrders = orders.where((order) =>
                widget.isAllowPending ? order.orderStatus == 'pending' : false ||
                    widget.isAllowReady ? order.orderStatus == 'ready' : false ||
                    widget.isAllowAccepted ? order.orderStatus == 'accepted' : false ||
                    widget.isAllowCompleted ? order.orderStatus == 'completed' : false ||
                    widget.isAllowCancelled ? order.orderStatus == 'cancelled' : false
                ).toList();
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    scrollDirection: Axis.vertical,
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      final Color color = switch (order.orderStatus) {
                        "pending" => Colors.grey, "accepted" => Colors.blue, "ready" => Colors.green, "completed" => Colors.green, "refunded" => Colors.red, _ => Colors.black
                      };
                      if (filteredOrders.isEmpty){
                        return Center(child: Image.asset("assets/mingming.png", ),);
                      }
                      return _Orders(
                        color: color,
                        order: order,
                      );
                    });
              } else if (state is OrderDeleted) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (state is OrderError) {
                return Text(state.message);
              } else {
                return const Text("Unexpected state}");
              }
            },

          ),
        ));
  }
}

class _Orders extends StatelessWidget {
  final OrderModel order;
  final Color color;

  const _Orders({super.key, required this.order, required this.color});

  @override
  Widget build(BuildContext context) {
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
              ),
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
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<OrderBloc>().add(DeleteOrder(order.orderId, order.stallId!));
                      },
                      child: const Text(
                        "Cancel Order",
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
