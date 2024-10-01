import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/models/stall_model.dart';

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
    context.read<FoodBloc>().add(LoadFood());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const _AppBar(),
        body: Stack(fit: StackFit.expand, children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.stall.imageUrl!,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 90,
            child: Center(
              child: Text(
                widget.stall.stallName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
              top: 230,
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: BlocBuilder<FoodBloc, FoodState>(
                      builder: (context, state) {
                        if (state is FoodLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is FoodLoaded) {
                          final foods = state.foods;
                          return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: foods.length,
                              itemBuilder: (context, index) {
                                final food = foods[index];
                                return HomeMealCard(food: food);
                              });
                        } else if (state is FoodError) {
                          return Text(state.message);
                        } else {
                          return const Text("Unexpected state");
                        }
                      }
                  ),
                )
              )),
        ]));
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8.0),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
