import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';
import 'package:upang_eat/fake_data.dart';
import 'package:upang_eat/pages/category_more.dart';
import 'package:upang_eat/repositories/category_repository_impl.dart';
import 'package:upang_eat/repositories/food_repository.dart';
import 'package:upang_eat/widgets/carousel.dart';
import '../bloc/category_bloc/category_bloc.dart';
import '../bloc/food_bloc/food_bloc.dart';
import '../bloc/stall_bloc/stall_bloc.dart';
import '../models/food_model.dart';
import '../repositories/food_repository_impl.dart';
import '../widgets/category_card.dart';
import '../widgets/home_meal_card.dart';
import '../widgets/home_stall_card.dart';
import 'food_category.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return BlocProvider(
      create: (context) => FoodBloc(FoodRepositoryImpl())..add(LoadFood()),
      child: Scaffold(
        appBar: _HomeAppBar(),
        drawer: const CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<StallBloc>().add(LoadStalls());
            context.read<CategoryBloc>().add(LoadCategory());
          },
          child: SingleChildScrollView(
            // padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                const _HomeSearchBar(),
                const _Header(title: "Categories", isHaveMore: true),
                _CategoriesHorizontalList(),
                const _Header(title: "Stalls", isHaveMore: true, bottomPadding: 0,),
                _StallCardHorizontalList(),
                const Carousel(),
                const _Header(title: "Meals"),
                const _MealCardVerticalList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Upang Eats"),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fastfood_outlined)),
            ],
          ),
        )
      ],
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final bool isHaveMore;
  final double topPadding;
  final double bottomPadding;

  const _Header(
      {required this.title, this.isHaveMore = false, this.topPadding = 8, this.bottomPadding = 8});

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
            GestureDetector(
              onTap: () {
                final route = switch (title) {
                  'Category' => const CategoryMore(),
                  'Stalls' => const Stalls(),
                  _ => const CategoryMore()
                };
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => route));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: Row(
                  children: [
                    Text(
                      "Expand",
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
      child: Card.filled(
        color: Colors.white,
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
          if (state is StallLoading) {
            return Skeletonizer(
              child: ListView.builder(itemCount: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HomeStallCard(stall: FakeData.fakeStall);
                  }),
            );
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

class _MealCardVerticalList extends StatefulWidget {

  const _MealCardVerticalList({super.key});

  @override
  State<_MealCardVerticalList> createState() => _MealCardVerticalListState();
}

class _MealCardVerticalListState extends State<_MealCardVerticalList> {
  static const int _itemsPerPage = 8;
  final FoodRepository _foodRepository = FoodRepositoryImpl();
 var _controller = 


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            if (state is FoodLoading) {
              return Skeletonizer(
                child: SizedBox(
                  width: 380,
                  height: 500,
                  child: ListView.builder(itemCount: 4,
                      itemBuilder: (context, index) {
                        return HomeMealCard(
                            food: FakeData.fakeFood, isShowStallName: true);
                      }),
                ),
              );
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
                    return HomeMealCard(food: food, isShowStallName: true,);
                  });
            } else if (state is FoodError) {
              return Text(state.message);
            } else {
              return const Text("Unexpected state");
            }
          }
      ),
    );
  }
}

class _CategoriesHorizontalList extends StatefulWidget {
  @override
  State<_CategoriesHorizontalList> createState() =>
      _CategoriesHorizontalListState();
}

class _CategoriesHorizontalListState extends State<_CategoriesHorizontalList> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Skeletonizer(
                child: SizedBox(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CategoryCard(category: FakeData.fakeCategory);
                      }),
                ),
              );
            } else if (state is CategoryLoaded) {
              final categories = state.categories;
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  FoodCategory(category: category,)));
                        });
                      },
                      child: CategoryCard(category: category),
                    );
                  });
            } else if (state is CategoryError) {
              return Text(state.message);
            } else {
              return const Text("Unexpected state");
            }
          }
      ),
    );
  }
}
