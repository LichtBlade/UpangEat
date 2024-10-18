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
    final currentDate = DateTime.now();
    final startDate = DateTime(currentDate.year, currentDate.month, currentDate.day); // Today's date
    final endDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

    context.read<AnalyticFoodBloc>().add(LoadAnalyticFood(globalUserData!.stallId!, "$startDate", "$currentDate"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analytics",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<AnalyticFoodBloc, AnalyticFoodState>(
        builder: (context, state) {
          print("Current State: $state");
          if (state is AnalyticFoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnalyticFoodLoaded) {
            final foodAnalytics = state.foodAnalytics;

            return ListView.builder(
              itemCount: foodAnalytics.length,
              itemBuilder: (context, index) {
                final foodItem = foodAnalytics[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(foodItem.itemName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('Total Sales: ${foodItem.totalQuantitySold}', style: const TextStyle(fontSize: 16)),
                  ),
                );
              },
            );
          } else if (state is AnalyticFoodError) {
            // Error state
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return const Center(child: Text("Unexpected State"));
          }
        },
      ),
    );
  }
}