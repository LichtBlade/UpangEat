import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, String> category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              category['categoryPicUrl']!,
              width: 55,
              height: 55,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Error loading image');
              },
            ),
          ),
        ),
        Text(category['categoryName']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)
      ],
    );
  }
}
