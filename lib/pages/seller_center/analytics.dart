import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/analytic_food_bloc/analytic_food_bloc.dart';
import '../../user_data.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

  @override
  void initState() {
    context.read<AnalyticFoodBloc>().add(LoadAnalyticFood(globalUserData!.stallId!, "2024-10-1", "2024-11-1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics"),),
      body: BlocBuilder<AnalyticFoodBloc, AnalyticFoodState>(
        builder: (context, state) {
          if(state is AnalyticFoodLoading){
            print("Analytic Loading");
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is AnalyticFoodLoaded){
            print("Analytics Loaded");
            final foodAnalytics = state.foodAnalytics;
            return FilledButton(onPressed: () {
              print(foodAnalytics);
            }, child: const Text("Print"));
          } else if (state is AnalyticFoodError){
            print("Analytic Error: ${state.message}");
            return Text(state.message);
          } else {
            print("Analytic Unexpected State");
            return const Text("Unexpected State");
          }
      
        },
      ),
    );
  }
}
