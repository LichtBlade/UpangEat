import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {

  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<Map<String, String>> categories = [
    {
      'categoryName' : 'Burgers',
      'categoryPicUrl' : 'categories/Burger.png'
    },
    {
      'categoryName' : 'Bread',
      'categoryPicUrl' : 'categories/Bread.png'
    },
    {
      'categoryName' : 'Dim sum',
      'categoryPicUrl' : 'categories/Dimsums.png'
    },
    {
      'categoryName' : 'Drinks',
      'categoryPicUrl' : 'categories/Drinks.png'
    },
    {
      'categoryName' : 'Fries',
      'categoryPicUrl' : 'categories/Fries.png'
    },
    {
      'categoryName' : 'Noodles',
      'categoryPicUrl' : 'categories/Noodles.png'
    },
    {
      'categoryName' : 'RiceMeal',
      'categoryPicUrl' : 'categories/RiceMeal.png'
    },
    {
      'categoryName' : 'Snack',
      'categoryPicUrl' : 'categories/Snack.png'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
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
      ),
    );
  }
}
