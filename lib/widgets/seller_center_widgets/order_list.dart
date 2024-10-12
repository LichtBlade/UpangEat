import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/order_item_model.dart';
import 'package:upang_eat/models/order_model.dart';

import '../../bloc/order_bloc/order_bloc.dart';

class OrderList extends StatefulWidget {
  final OrderModel order;
  const OrderList({super.key, required this.order});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: [
          _Header(order: widget.order,),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16 ),
            child: ListView.builder(
              itemCount: widget.order.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = widget.order.items[index];
                return _OrderItem(item: item,);
              },
            ),
          ),
          const _TotalPrice(),
        ],
      ),
    );
  }

}

class _Header extends StatelessWidget {
  final OrderModel order;
  const _Header({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel,
                size: 30,
                color: Color.fromARGB(255, 222, 15, 57),
              )),
          Text(
            'Order #${order.orderId}',
            style:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          IconButton(
              onPressed: () {
                String status = switch(order.orderStatus){
                  "pending" => "accepted",
                  "accepted" => "ready",
                  _ => "cancelled"
                };
                print(status);
                context.read<OrderBloc>().add(UpdateOrder(order.orderId, order.stallId! ,status));
              }, icon: const Icon(Icons.check_circle, color: Colors.green, size: 30,)),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final OrderItemModel item;
  const _OrderItem({super.key, required this.item});

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
              child: Image.asset(
                item.imageUrl!,
                fit: BoxFit.cover,
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
  const _TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('₱200',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
              ))
        ],
      ),
    );
  }
}

