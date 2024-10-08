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
      'price': '400',
      'quantity': '2'
    },
    {
      'image': 'assets/foods/1_1.jpg',
      'productName': 'Sisid',
      'price': '400',
      'quantity': '3'
    },
    {
      'image': 'assets/foods/1_1.jpg',
      'productName': 'Stick',
      'price': '400',
      'quantity': '1'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Order List',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.cancel)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: orderItems
                      .map((item) => buildOrderItem(item['image'],
                          item['productName'], item['quantity'], item['price']))
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildOrderItem(
      String image, String productName, String quantity, String price) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              height: 75,
              width: 125,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₱$price',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${quantity}x',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
