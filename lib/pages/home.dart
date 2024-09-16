import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:upang_eat/widgets/categories_widget.dart';
import 'package:upang_eat/widgets/home_meal_card_vertical_list.dart';
import 'package:upang_eat/widgets/home_search_bar.dart';
import 'package:upang_eat/widgets/home_stall_card_horizontal_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> foods = [
    "assets/BossSisigBanner.jpg",
    "assets/BossSisigBanner.jpg",
    "assets/BossSisigBanner.jpg",
    "assets/BossSisigBanner.jpg",
    "assets/BossSisigBanner.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 8.0),
        children: [
          const HomeSearchBar(),
          //Categories
          const Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          const CategoriesWidget(),
          //Stalls
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Stalls",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const HomeStallCardHorizontalList(),
          //Meals
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Meals",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          HomeMealCardVerticalList(foods: foods),
        ],
      ),
    );
  }
}
