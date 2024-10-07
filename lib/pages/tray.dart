import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:upang_eat/Widgets/stalls_stall_card.dart";
import "package:upang_eat/bloc/tray_bloc/tray_bloc.dart";
import "package:upang_eat/models/food_model.dart";
import "package:upang_eat/models/tray_model.dart";

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tray"),
      ),
      body: BlocListener<TrayBloc, TrayState>(
        listener: (context, state) {
          if (state is TrayItemRemoved){
            context.read<FoodBloc>().add(LoadFoodTray(widget.id));
          } else if (state is TrayError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            print(state.message);
          }
        },
        child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            if (state is FoodLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FoodLoaded) {
              final foods = state.foods;
              return foods.isNotEmpty ?
              ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return TrayCard(food: food);
                  })
                  : const Text("Empty");
            } else if (state is FoodError) {
              return Text(state.message);
            } else {
              return const Text("Unexpected state");
            }
          },
        ),
      ),
    );
  }
}
