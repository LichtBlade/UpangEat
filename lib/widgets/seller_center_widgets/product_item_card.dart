import 'package:flutter/material.dart';

class ProductItemCard extends StatefulWidget {
  // Requires atleast product title and Image
  final String productTitle;
  final String productImage;
  final int productPrice;
  final Function()? onTap;

  const ProductItemCard(
      {super.key,
      required this.productTitle,
      required this.productImage,
      required this.productPrice,
      this.onTap});

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  String title = '';
  String image = '';
  int price = 0;
  Function()? onTap;

  @override
  void initState() {
    super.initState();

    title = widget.productTitle;
    image = widget.productImage;
    price = widget.productPrice;
    onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Custom functionality
      onTap: onTap,
      // Card
      child: Card(
        elevation: 8.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(image, fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: Text(
                            '₱$price',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
