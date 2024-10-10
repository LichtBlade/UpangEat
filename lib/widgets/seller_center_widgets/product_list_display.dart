import 'package:flutter/material.dart';

class ProductListDisplay extends StatefulWidget {
  const ProductListDisplay({super.key});

  @override
  State<ProductListDisplay> createState() => _ProductListDisplayState();
}

class _ProductListDisplayState extends State<ProductListDisplay> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6.0),
      elevation: 2,
      color: const Color.fromARGB(255, 237, 237, 237),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 250,
                maxHeight: 500,
              ),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
