import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/seller_center_widgets/product_item_card.dart';
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";

class ProductsCard extends StatefulWidget {
  //For custom button and Item functinality
  final List<Map<String, dynamic>>? productData;
  final Function()? nextButtonFunction;
  final Function()? listItemFunction;

  const ProductsCard(
      {super.key,
      this.productData,
      this.nextButtonFunction,
      this.listItemFunction});

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  List<Map<String, dynamic>>? prdctData;
  Function()? nxtBtnFunction;
  Function()? itemFunc;

  //Placeholder product data
  final List<Map<String, dynamic>> _productData = [
    {'title': 'Steak', 'image': 'assets/steak.jpg', 'price': 32},
    {'title': 'Steak', 'image': 'assets/steak.jpg', 'price': 32},
    {'title': 'Sisig', 'image': 'assets/sisig.jpg', 'price': 50},
    {'title': 'Meat', 'image': 'assets/meat.jpeg', 'price': 69},
    {'title': 'Steak', 'image': 'assets/steak.jpg', 'price': 32},
    {'title': 'Steak', 'image': 'assets/steak.jpg', 'price': 32},
    {'title': 'Meat', 'image': 'assets/meat.jpeg', 'price': 69},
    {'title': 'Steak', 'image': 'assets/steak.jpg', 'price': 32},
    {'title': 'Meat', 'image': 'assets/meat.jpeg', 'price': 69},
    {'title': 'Meat', 'image': 'assets/meat.jpeg', 'price': 69},
    {'title': 'Sisig', 'image': 'assets/sisig.jpg', 'price': 50},
  ];

  @override
  void initState() {
    super.initState();

    prdctData = widget.productData;
    nxtBtnFunction = widget.nextButtonFunction;
    itemFunc = widget.listItemFunction;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 70.0, bottom: 4.0, left: 8.0, right: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card title
            Row(
              children: [
                const Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: IconButton(
                    onPressed:
                        nxtBtnFunction, // Custom icon button functionality
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              ],
            ),

            // Card list
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 485, minHeight: 100),
              // Mason Grid view
              child: MasonryGridView.builder(
                itemCount: _productData.length,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = _productData[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductItemCard(
                      productTitle: product['title'],
                      productImage: product['image'],
                      productPrice: product['price'],
                      onTap: itemFunc,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
