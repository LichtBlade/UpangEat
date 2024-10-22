import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/widgets/seller_center_widgets/monthly_analytics.dart';
import '../../bloc/analytic_food_bloc/analytic_food_bloc.dart';
import '../../repositories/food_repository_impl.dart';
import '../../user_data.dart';
import '../../widgets/seller_center_widgets/daily_analytics.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    final foodRepository = FoodRepositoryImpl();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analytics Overview",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text('Current Sales'),
          Expanded(
            child: BlocProvider<AnalyticFoodBloc>(
              create: (context) => AnalyticFoodBloc(foodRepository)
                ..add(LoadAnalyticFood(globalUserData!.stallId!, "${DateTime.now().toIso8601String()}", "${DateTime.now().toIso8601String()}")),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: DailyAnalytics(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Monthly Sales'),
          // Separate BlocProvider for MonthlyAnalytics
          Expanded(
            child: BlocProvider<AnalyticFoodBloc>(
              create: (context) => AnalyticFoodBloc(foodRepository)
                ..add(LoadAnalyticFood(globalUserData!.stallId!, "${DateTime(DateTime.now().year, DateTime.now().month, 1).toIso8601String()}", "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0).toIso8601String()}")),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: MonthlyAnalytics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
