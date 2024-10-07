import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:upang_eat/bloc/tray_bloc/tray_bloc.dart';
import "../bloc/food_bloc/food_bloc.dart";
import "../fake_data.dart";
import "../widgets/tray_card.dart";

class Tray extends StatefulWidget {
  final int id = 1; // TODO Change to logged in user id
  const Tray({super.key});

  @override
  State<Tray> createState() => _TrayState();
}

class _TrayState extends State<Tray> {
  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(LoadFoodTray(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            int productCount = 0;
            if (state is FoodLoaded) {
              productCount = state.foods.length;
            }
            return Text("Tray ($productCount)");
          },
        ),
      ),
      child: SafeArea(
        child: BlocListener<TrayBloc, TrayState>(
          listener: (context, state) {
            if (state is TrayItemRemoved) {
              context.read<FoodBloc>().add(LoadFoodTray(widget.id));
            } else if (state is TrayError) {
              CupertinoAlertDialog alert = CupertinoAlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
              showCupertinoDialog(context: context, builder: (context) => alert);
            }
          },
          child: BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state is FoodLoading) {
                return Skeletonizer(
                  child: ListView.builder(
                    itemCount: 8,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemBuilder: (context, index) {
                      return TrayCard(food: FakeData.fakeFood);
                    },
                  ),
                );
              } else if (state is FoodLoaded) {
                final foods = state.foods;
                return foods.isNotEmpty
                    ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return TrayCard(food: food);
                  },
                )
                    : const Center(child: Text("Empty"));
              } else if (state is FoodError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Unexpected state"));
              }
            },
          ),
        ),
      ),
    );
  }
}
