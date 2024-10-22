import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:upang_eat/models/order_model.dart';

import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/wallet_bloc/wallet_bloc.dart';
import '../user_data.dart';

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
            } else if (state is OrderLoaded) {
              if (state.message.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Order Already Accepted"),
                          content: const Text("Unfortunately, your order has already been accepted by the seller and cannot be canceled. Please contact the seller directly if you have any concerns."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"))
                          ],
                        ));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OrderLoaded) {
                final orders = state.order;
                print(orders);
                final filteredOrders =
                    orders.where((order) => (widget.isAllowPending ? order.orderStatus == 'pending' : false) || (widget.isAllowReady ? order.orderStatus == 'ready' : false) || (widget.isAllowAccepted ? order.orderStatus == 'accepted' : false)).toList();
                print("$filteredOrders");
                print("Pending ${widget.isAllowPending}");
                print("ready ${widget.isAllowReady}");
                print("accepted ${widget.isAllowAccepted}");
                print("completed ${widget.isAllowCompleted}");
                print("cancelled ${widget.isAllowCancelled}");
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    scrollDirection: Axis.vertical,
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      final Color color = switch (order.orderStatus) { "pending" => Colors.grey, "accepted" => Colors.blue, "ready" => Colors.green, "completed" => Colors.green, "refunded" => Colors.red, _ => Colors.black };
                      if (filteredOrders.isEmpty) {
                        return Center(
                          child: Image.asset(
                            "assets/mingming.png",
                          ),
                        );
                      }
                      return _Orders(
                        color: color,
                        order: order,
                      );
                    });
              } else if (state is OrderDeleted) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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

  double convertPhpToEth(double totalPayment) {
    if (globalEthPrice > 0) {
      // Ensure the ETH price is not zero to avoid division by zero
      ethAmount = totalPayment / globalEthPrice; // Convert PHP to ETH
      return ethAmount; // Return the amount in ETH
    } else {
      print("Error: ETH price is zero or not set.");
      return 0.0; // Return 0.0 if ETH price is not available
    }
  }

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
                order.orderStatus == "pending"
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Cancel Order?"),
                                    content: const Text("This action cannot be undone. The payment will be returned to you"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          print(order.totalAmount);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<OrderBloc>().add(DeleteOrder(order.orderId, order.userId));

                                          Navigator.pop(context);
                                          final convertToEth = convertPhpToEth(order.totalAmount.toDouble());
                                          context.read<WalletBloc>().add(LoadEthBalance(convertToEth, globalPaymentEth));
                                        },
                                        child: const Text("Confirm"),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                            "Cancel Order",
                          ),
                        ))
                    : order.orderStatus == "ready"
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: FilledButton(
                                onPressed: () {
                                  print(globalUserData!.userId);
                                  context.read<OrderBloc>().add(UpdateUserOrder(order.orderId, globalUserData!.userId, "completed"));
                                },
                                child: const Text("Order Received")))
                        : const SizedBox.shrink()
              ],
            )
          ],
        ),
      ),
    );
  }
}
