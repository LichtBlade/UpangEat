import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Pages/tray.dart';
import 'package:upang_eat/bloc/category_bloc/category_bloc.dart';
import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/widgets/category_card.dart';
import 'package:upang_eat/widgets/home_stall_card.dart';
import 'package:upang_eat/widgets/home_meal_card.dart';
import 'package:upang_eat/widgets/carousel.dart';
import '../widgets/custom_drawer.dart';
import 'category_more.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<StallBloc>().add(LoadStalls());
    context.read<FoodBloc>().add(LoadFood());
    context.read<CategoryBloc>().add(LoadCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Upang Eats"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.cart),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const Tray()),
            );
          },
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.bars),
          onPressed: () {
            // Show the CustomCupertinoMenu as a modal popup
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return const CustomDrawer();
              },
            );
          },
        ),
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const _HomeSearchBar()),
              SliverToBoxAdapter(child: const _Header(title: "Categories", isHaveMore: true)),
              SliverToBoxAdapter(child: _CategoriesHorizontalList()),
              SliverToBoxAdapter(child: const _Header(title: "Stalls", isHaveMore: true, bottomPadding: 0)),
              SliverToBoxAdapter(child: _StallCardHorizontalList()),
              SliverToBoxAdapter(child: const Carousel()),
              SliverToBoxAdapter(child: const _Header(title: "Meals")),
              SliverToBoxAdapter(child: const _MealCardVerticalList()),
            ],
          ),
        ),
      ),

    );
  }
}


class _Header extends StatelessWidget {
  final String title;
  final bool isHaveMore;
  final double topPadding;
  final double bottomPadding;

  const _Header({
    required this.title,
    this.isHaveMore = false,
    this.topPadding = 8,
    this.bottomPadding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Row(
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
            GestureDetector(
              onTap: () {
                final route = title == 'Categories'
                    ? const CategoryMore()
                    : const Stalls();
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => route),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: Row(
                  children: [
                    Text(
                      "Expand",
                      style: TextStyle(fontSize: 11),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      CupertinoIcons.forward,
                      size: 11.0,
                    ),
                  ],
                ),
              ),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: CupertinoSearchTextField(
        placeholder: "What would you like to have?",
        padding: const EdgeInsets.all(12),
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
          if (state is StallLoading) {
            return CupertinoActivityIndicator();
          } else if (state is StallLoaded) {
            final stallData = state.stalls;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              itemCount: stallData.length,
              itemBuilder: (context, index) {
                final stall = stallData[index];
                return HomeStallCard(stall: stall);
              },
            );
          } else if (state is StallError) {
            return Text("Error: ${state.message}");
          } else {
            return const Text("Unexpected state");
          }
        },
      ),
    );
  }
}

class _MealCardVerticalList extends StatelessWidget {
  const _MealCardVerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return CupertinoActivityIndicator();
          } else if (state is FoodLoaded) {
            final foods = state.foods;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return HomeMealCard(food: food, isShowStallName: true);
              },
            );
          } else if (state is FoodError) {
            return Text(state.message);
          } else {
            return const Text("Unexpected state");
          }
        },
      ),
    );
  }
}

class _CategoriesHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return CupertinoActivityIndicator();
          } else if (state is CategoryLoaded) {
            final categories = state.categories;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(category: category);
              },
            );
          } else if (state is CategoryError) {
            return Text("Error: ${state.message}");
          } else {
            return const Text("Unexpected state");
          }
        },
      ),
    );
  }
}
