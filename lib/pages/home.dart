import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/Pages/stalls.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';
import 'package:upang_eat/fake_data.dart';
import 'package:upang_eat/pages/category_more.dart';
import 'package:upang_eat/pages/notifications.dart';
import 'package:upang_eat/pages/order_status.dart';
import 'package:upang_eat/pages/tray.dart';
import 'package:upang_eat/repositories/food_repository.dart';
import 'package:upang_eat/repositories/order_repository.dart';
import 'package:upang_eat/repositories/order_repository_impl.dart';
import 'package:upang_eat/user_data.dart';
import 'package:upang_eat/widgets/carousel.dart';
import '../bloc/category_bloc/category_bloc.dart';
import '../bloc/food_bloc/food_bloc.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/notification_bloc/notification_bloc.dart';
import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/stall_bloc/stall_bloc.dart';
import '../models/order_model.dart';
import '../repositories/food_repository_impl.dart';
import '../repositories/stall_repository_impl.dart';
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
    // context.read<OrderBloc>().add(UserFetchOrder(globalUserData?.userId ?? 0));
    // context.read<CategoryBloc>().add(LoadCategory());
    // context.read<NotificationBloc>().add(FetchNotification(globalUserData!.userId));
    // super.initState();
    super.initState(); // Call super first to ensure the base class is initialized.

    final userId = globalUserData?.userId; // Nullable userId

    // Fetch orders
    context.read<OrderBloc>().add(UserFetchOrder(userId ?? 0)); // Fallback to 0 if userId is null
    context.read<CategoryBloc>().add(LoadCategory());

    // Fetch notifications only if globalUserData is not null
    if (globalUserData != null) {
      context.read<NotificationBloc>().add(FetchNotification(userId!)); // Safe to use ! here
    } else {
      // Handle the case where globalUserData is null if necessary
      // For example, you might want to log a message or provide a default notification
    }
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FoodBloc(FoodRepositoryImpl())..add(LoadFood()),
        ),
        BlocProvider(
          create: (context) => StallBloc(StallRepositoryImpl())..add(LoadStalls()),
        ),
      ],
      child: Scaffold(
        appBar: _HomeAppBar(),
        drawer: CustomDrawer(),
        floatingActionButton: const _FloatingActionBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<StallBloc>().add(LoadStalls());
            context.read<CategoryBloc>().add(LoadCategory());
            context.read<FoodBloc>().add(LoadFood());
            context.read<OrderBloc>().add(UserFetchOrder(globalUserData?.userId ?? 0));
          },
          child: CustomScrollView(
            slivers: [
              // const SliverToBoxAdapter(
              //   child: _HomeSearchBar(),
              // ),
              const SliverToBoxAdapter(
                child: _Header(title: "Categories"),
              ),
              SliverToBoxAdapter(
                child: _CategoriesHorizontalList(),
              ),
              const SliverToBoxAdapter(
                child: _Header(
                  title: "Stalls",
                  isHaveMore: true,
                  bottomPadding: 0,
                ),
              ),
              SliverToBoxAdapter(
                child: _StallCardHorizontalList(),
              ),
              // const SliverToBoxAdapter(
              //   child: Carousel(),
              // ),
              const SliverToBoxAdapter(
                child: _Header(title: "Meals"),
              ),
              const _MealCardVerticalList()
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<_HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<_HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Upang Eats"),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(onPressed: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications())).then((_) {

                      context.read<NotificationBloc>().add(FetchNotification(globalUserData!.userId));

                  });
                });
              }, icon: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoaded){
                    int unreadNotificationCount = state.notifications.where((notification)=> notification.status == "unread").length;

                    if (unreadNotificationCount < 1){
                      return const Icon(Icons.notifications_outlined);
                    }

                    return Badge.count(
                      count: unreadNotificationCount,
                      child: const Icon(Icons.notifications_outlined),
                    );
                  }
                  return const Icon(Icons.notifications_outlined);

                },
              )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Tray(
                                    id: globalUserData!.userId,
                                  ))).then((value) {
                        if (value == true) {
                          setState(() {});
                        }
                      });
                    });
                  },
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
            GestureDetector(
              onTap: () {
                print(globalUserData);
                final route = switch (title) { 'Category' => const CategoryMore(), 'Stalls' => const Stalls(), _ => const CategoryMore() };
                Navigator.push(context, MaterialPageRoute(builder: (context) => route));
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
            return const SkeletonStallCard();
          } else if (state is StallLoaded) {
            final stallData = state.stalls;
            stallData.shuffle();

            final activeStalls = stallData.where((stall) => stall.isActive).toList(); 

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              itemCount: activeStalls.length, 
              itemBuilder: (context, index) {
                final stall = activeStalls[index];
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

class _FloatingActionBar extends StatefulWidget {
  const _FloatingActionBar({super.key});

  @override
  State<_FloatingActionBar> createState() => _FloatingActionBarState();
}

class _FloatingActionBarState extends State<_FloatingActionBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          print("Order is loading");
        } else if (state is OrderLoaded) {
          print("Order is loaded");
          final List<OrderModel> orders = state.order;
          final hasRelevantOrders = orders.any((order) => order.orderStatus == 'pending' || order.orderStatus == 'ready' || order.orderStatus == 'accepted');
          if (!hasRelevantOrders) {
            return const SizedBox.shrink();
          }
          return SizedBox(
            width: 250,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderStatus(
                              isAllowPending: true,
                              isAllowAccepted: true,
                              isAllowReady: true,
                            )));
              },
              extendedIconLabelSpacing: 16.0,
              icon: const Icon(Icons.my_library_books),
              label: const Text(
                "Check Order Status",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else if (state is OrderError) {
          print("error: ${state.message}");
        } else {
          print("Unexpected state");
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _MealCardVerticalList extends StatefulWidget {
  const _MealCardVerticalList({super.key});

  @override
  State<_MealCardVerticalList> createState() => _MealCardVerticalListState();
}

class _MealCardVerticalListState extends State<_MealCardVerticalList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
      if (state is FoodLoading) {
        print("Food is loading");
        return const SliverToBoxAdapter(
          child: SkeletonHomeMealCard(),
        );
      } else if (state is FoodLoaded) {
        print("Food is loaded");
        final foods = state.foods;
        foods.shuffle();
        return SliverList(
          delegate: SliverChildBuilderDelegate(childCount: foods.length, (BuildContext context, int index) {
            final food = foods[index];
            return HomeMealCard(
              food: food,
              isShowStallName: true,
              isOnHome: false, //HWMEH
            );
          }),
        );
      } else if (state is FoodError) {
        return SliverToBoxAdapter(child: Text(state.message));
      } else {
        return const SliverToBoxAdapter(child: Text("Unexpected state"));
      }
    });
  }
}

class _CategoriesHorizontalList extends StatefulWidget {
  @override
  State<_CategoriesHorizontalList> createState() => _CategoriesHorizontalListState();
}

class _CategoriesHorizontalListState extends State<_CategoriesHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        if (state is CategoryLoading) {
          return const SkeletonCategoryCard();
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodCategory(
                                    category: category,
                                  )));
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
      }),
    );
  }
}

class SkeletonHomeMealCard extends StatelessWidget {
  const SkeletonHomeMealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
        width: 380,
        height: 500,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return HomeMealCard(food: FakeData.fakeFood, isShowStallName: true);
            }),
      ),
    );
  }
}

class SkeletonCategoryCard extends StatelessWidget {
  const SkeletonCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}

class SkeletonStallCard extends StatelessWidget {
  const SkeletonStallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
          itemCount: 4,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return HomeStallCard(stall: FakeData.fakeStall);
          }),
    );
  }
}
