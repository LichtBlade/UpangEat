import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/widgets/carousel.dart';
import '../bloc/stall_bloc/stall_bloc.dart';
import '../widgets/category_card.dart';
import '../widgets/home_meal_card.dart';
import '../widgets/home_stall_card.dart';

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
          const _HomeSearchBar(),
          const _Header(title: "Categories", isHaveMore: true),
          _CategoriesHorizontalList(),
          const _Header(title: "Stalls", isHaveMore: true, bottomPadding: 0,),
          _StallCardHorizontalList(),
          const Carousel(),
          const _Header(title: "Meals"),
          _MealCardVerticalList(foods: foods),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final bool isHaveMore;
  final double topPadding;
  final double bottomPadding;
  const _Header({required this.title, this.isHaveMore = false, this.topPadding = 8, this.bottomPadding = 8});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          if (isHaveMore)
            const Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Row(
                children: [
                  Text(
                    "View more",
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                    size: 11.0,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}

class _HomeSearchBar extends StatelessWidget {
  const _HomeSearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Container(
        width: 320,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              )
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                hintText: "What would you like to have?",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StallCardHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      child: BlocBuilder<StallBloc, StallState>(
        builder: (context, state) {
          if (state is StallInitial) {
            context.read<StallBloc>().add(LoadStalls());
            return const CircularProgressIndicator();
          } else if (state is StallLoading) {
            return const CircularProgressIndicator();
          } else if (state is StallLoaded) {
            final stallData = state.stalls;
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                scrollDirection: Axis.horizontal,
                itemCount: stallData.length,
                itemBuilder: (context, index) {
                  final stall = stallData[index];
                  return HomeStallCard(stall: stall);
                });
          } else if (state is StallError) {
            return Text("Error: ${state.message}");
          } else {
            return const Text("Unexpected state}");
          }
        },
      ),
    );
  }
}

class _MealCardVerticalList extends StatelessWidget {
  final List<String> foods;
  const _MealCardVerticalList({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return HomeMealCard(food: food);
        });
  }
}

class _CategoriesHorizontalList extends StatelessWidget {
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

  _CategoriesHorizontalList({super.key});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(category: category);
          }
      ),
    );
  }
}
