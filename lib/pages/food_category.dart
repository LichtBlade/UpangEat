import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';
import 'package:upang_eat/models/category_model.dart';

import '../bloc/food_bloc/food_bloc.dart';
import '../widgets/home_meal_card.dart';

class FoodCategory extends StatefulWidget {
  final CategoryModel category;

  const FoodCategory({super.key, required this.category});

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(LoadFoodCategory(widget.category.categoryId));
  }
  @override
  Widget build(BuildContext context) {
    print("wwwowww ${widget.category}");
    return Scaffold(
      appBar: _AppBar(title: widget.category.categoryName,),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return const CircularProgressIndicator();
          } else if (state is FoodLoaded) {
            final foods = state.foods;
            print("eyo $foods");
            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return HomeMealCard(food: food);
                });
          } else if (state is FoodError) {

          } else {
            return const Text("Unexpected state}");
          }
          return const Text("Unexpected state}");
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _AppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
