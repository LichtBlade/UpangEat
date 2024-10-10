// TODO: Remake to take items from list
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
    return Card(
      elevation: 8,
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
                    'Order #001',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.check)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cancel,
                            color: Color.fromARGB(255, 222, 15, 57),
                          )),
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
            ),
          ),
          const Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('₱200',
                    style: TextStyle(
                      fontSize: 20.0,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                  Text(
                    'x$quantity',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
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
