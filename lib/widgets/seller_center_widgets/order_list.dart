import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/order_item_model.dart';
import 'package:upang_eat/models/order_model.dart';

import '../../bloc/order_bloc/order_bloc.dart';
import '../../main.dart';

class OrderList extends StatefulWidget {
  final OrderModel order;
  final bool isCompletedOrCancelled;
  const OrderList({super.key, required this.order, this.isCompletedOrCancelled = false});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: [
          _Header(
            order: widget.order,
            isCompletedOrCancelled: widget.isCompletedOrCancelled,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView.builder(
              itemCount: widget.order.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = widget.order.items[index];
                return _OrderItem(
                  item: item,
                  stallId: widget.order.stallId!,
                );
              },
            ),
          ),
           _TotalPrice(price: widget.order.totalAmount,),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final OrderModel order;
  final bool isCompletedOrCancelled;
  const _Header({super.key, required this.order, required this.isCompletedOrCancelled});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: isCompletedOrCancelled
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${order.orderId}',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                    ),
                    Row(
                      children: [
                        Text(order.orderDate!),
                        const SizedBox(width: 8,),
                        Text(order.orderStatus!, style: TextStyle(color: order.orderStatus! == "completed" ? Colors.green : Colors.red),),
                      ],
                    )
                  ],
                ),
            )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Cancel Order?"),
                                content: const Text("Are you sure you want to cancel this order?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context.read<OrderBloc>().add(UpdateOrder(order.orderId, order.stallId!, "cancelled"));
                                      },
                                      child: const Text("Yes"))
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 30,
                        color: Color.fromARGB(255, 222, 15, 57),
                      )),
                  Text(
                    'Order #${order.orderId}',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  IconButton(
                      onPressed: () {
                        String status = switch (order.orderStatus) { "pending" => "accepted", "accepted" => "ready", "ready" => "completed", _ => "cancelled" };
                        print(status);
                        context.read<OrderBloc>().add(UpdateOrder(order.orderId, order.stallId!, status));
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      )),
                ],
              ));
  }
}

class _OrderItem extends StatelessWidget {
  final OrderItemModel item;
  final int stallId;
  const _OrderItem({super.key, required this.item, required this.stallId});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              height: 65,
              width: 65,
              child: Image.network(
                "${IpAddress.ipAddress}/uploads/${stallId}_${item.itemId}.jpg",
                fit: BoxFit.cover,errorBuilder:
                  (context, error, stackTrace) {
                return const Text('Error loading image');
              }
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '₱${item.subtotal}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              'x${item.quantity}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TotalPrice extends StatelessWidget {
  final int price;
  const _TotalPrice({super.key, this.price = 0});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('₱ $price', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
