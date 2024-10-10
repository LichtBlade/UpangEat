import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<Map<String, dynamic>> orderItems = [
    {
      'image': 'assets/foods/1_1.jpg',
      'productName': 'Meant',
      'price': 400,
      'quantity': 2
    },
    {
      'image': 'assets/foods/1_1.jpg',
      'productName': 'Sisid',
      'price': 400,
      'quantity': 3
    },
    {
      'image': 'assets/foods/1_1.jpg',
      'productName': 'Stick',
      'price': 400,
      'quantity': 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: [
          const _Header(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16 ),
            child: Column(
              children: orderItems
                  .map((item) => buildOrderItem(item['image'],
                      item['productName'], item['quantity'], item['price']))
                  .toList(),
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('₱200',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderItem(
      String image, String productName, int quantity, int price) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              height: 95,
              width: 95,
              child: Image.asset(
                image,
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
                    productName,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₱$price',
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
              'x$quantity',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

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
                size: 28,
                color: Color.fromARGB(255, 222, 15, 57),
              )),
          const Text(
            'Order #001',
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.check_circle, color: Colors.green, size: 28,)),
        ],
      ),
    );
  }
}
