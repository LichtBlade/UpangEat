import 'package:flutter/material.dart';
import 'package:upang_eat/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card.filled(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              category.imageUrl!,
              width: 55,
              height: 55,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Error loading images');
              },
            ),
          ),
        ),
        Text(category.categoryName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)
      ],
    );
  }
}
