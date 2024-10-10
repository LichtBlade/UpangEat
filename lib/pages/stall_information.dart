import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/pages/tray.dart';
import 'package:upang_eat/widgets/meal_card_square.dart';

import '../bloc/food_bloc/food_bloc.dart';
import '../widgets/home_meal_card.dart';

class StallInformation extends StatefulWidget {
  final Stall stall;
  const StallInformation({super.key, required this.stall});

  @override
  State<StallInformation> createState() => _StallInformationState();
}

class _StallInformationState extends State<StallInformation> {
  @override
  void initState() {
    context.read<FoodBloc>().add(LoadFoodByStallId(widget.stall.stallId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const _AppBar(),
        body: Stack(fit: StackFit.expand, children: [
          _StallImage(imageUrl: widget.stall.imageUrl!),
          const _Gradient(),
          _StallName(stallName: widget.stall.stallName,),
          Positioned(
              top: 180,
              bottom: 0,
              left: 0,
              right: 0,
              child: Card.outlined(
                  color:  const Color(0xFFF8F8F8),
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      children: [
                        const SizedBox(height: 12,),
                        const _Header(icon: Icons.recommend, iconSize: 26, title: "Recommendation",isSubtitle: true,),
                        const SizedBox(height: 4,),
                        BlocBuilder<FoodBloc, FoodState>(
                            builder: (context, state) {
                              if (state is FoodLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is FoodLoaded) {
                                final foods = state.foods;
                                return GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 1/1
                                    ),
                                    padding:const EdgeInsets.symmetric(horizontal: 8.0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      final food = foods[index];
                                      return MealCardSquare(
                                        food: food,
                                      );
                                    });
                              } else if (state is FoodError) {
                                return Text(state.message);
                              } else {
                                return const Text("Unexpected state");
                              }
                            }),
                        const SizedBox(height: 12,),
                        const _Header(icon: Icons.menu_book, iconSize: 26, title: "Everything on the Menu",isSubtitle: false,),
                        const SizedBox(height: 4,),
                        BlocBuilder<FoodBloc, FoodState>(
                            builder: (context, state) {
                              if (state is FoodLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is FoodLoaded) {
                                final foods = state.foods;
                                return ListView.builder(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: foods.length,
                                    itemBuilder: (context, index) {
                                      final food = foods[index];
                                      return HomeMealCard(
                                        food: food,
                                        isShowStallName: false,
                                      );
                                    });
                              } else if (state is FoodError) {
                                return Text(state.message);
                              } else {
                                return const Text("Unexpected state");
                              }
                            }),
                      ],
                    ),
                  ))),
        ]));
  }
}

class _AppBar extends StatefulWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  State<_AppBar> createState() => _AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarState extends State<_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         setState(() {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => const Tray())).then((value) {
      //             if (value == true) {
      //               setState(() {});
      //             }
      //           });
      //         });
      //       },
      //       icon: const Icon(Icons.fastfood_outlined, color: Colors.white,))
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StallImage extends StatelessWidget {
  final String imageUrl;
  const _StallImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imageUrl,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
      ),
    );
  }
}

class _Gradient extends StatelessWidget {
  const _Gradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 70,
      child: Container(
        height: 140,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.transparent,
              Color.fromARGB(90, 255, 123, 123)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ),
    );
  }
}

class _StallName extends StatelessWidget {
  final String stallName;
  const _StallName({super.key, required this.stallName});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 60,
      child: SizedBox(
        height: 70,
        child: Center(
          child: Text(
            stallName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isSubtitle;
  final IconData? icon;
  final String title;
  final double iconSize;
  const _Header({super.key, required this.isSubtitle, required this.icon, required this.title, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: const TextStyle(
                // shadows: [
                //   Shadow(
                //     offset: Offset(2.0, 2.0),
                //     blurRadius: 6.0,
                //     color: Colors.grey,
                //   ),
                // ],
                  fontWeight: FontWeight.w500,
                  fontSize: 22),
            )
          ],
        ),
        if (isSubtitle)
          const Text(
            "Most ordered right now",
            style: TextStyle(
              // shadows: [
              //   Shadow(
              //     offset: Offset(2.0, 2.0),
              //     blurRadius: 3.0,
              //     color: Colors.grey,
              //   ),
              // ],
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color.fromARGB(255, 121, 116, 126)),
          )
      ],
    );
  }
}