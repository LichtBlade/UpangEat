import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/analytic_food_bloc/analytic_food_bloc.dart';
import '../../user_data.dart';
import '../admin_widgets/customcard.dart';

class DailyAnalytics extends StatefulWidget {
  const DailyAnalytics({super.key});

  @override
  State<DailyAnalytics> createState() => _DailyAnalytics();
}

class _DailyAnalytics extends State<DailyAnalytics> {
  @override
  void initState() {
    final currentDate = DateTime.now();
    final startDate = DateTime(currentDate.year, currentDate.month, currentDate.day); //dapat current date pero previous date
    final endDate = DateTime(currentDate.year, currentDate.month, currentDate.day + 1); //dapat next date pero current date

    context.read<AnalyticFoodBloc>().add(LoadAnalyticFood(globalUserData!.stallId!, "$startDate", "$endDate"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnalyticFoodBloc, AnalyticFoodState>(
        builder: (context, state) {
          if (state is AnalyticFoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnalyticFoodLoaded) {
            final foodAnalytics = state.foodAnalytics;

            if (foodAnalytics.isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            // Calculate max value for y-axis scaling
            double maxYValue = foodAnalytics
                .map((foodItem) => double.tryParse(foodItem.totalQuantitySold) ?? 0.0)
                .reduce((a, b) => a > b ? a : b);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: CustomCard(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      barGroups: foodAnalytics.asMap().entries.map((entry) {
                        int index = entry.key;
                        var foodItem = entry.value;

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: double.tryParse(foodItem.totalQuantitySold) ?? 0.0,
                              width: 20,
                              color: Color.fromARGB(255, 222, 15, 57),
                            ),
                          ],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final foodItem = foodAnalytics[value.toInt()];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Transform.translate(
                                  offset: const Offset(0, 40),
                                  child: Transform.rotate(
                                    angle: 1.55,
                                    child: Text(
                                      foodItem.itemName.length > 10
                                          ? '${foodItem.itemName.substring(0, 10)}...'
                                          : foodItem.itemName,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: maxYValue / 4, // Adjust interval based on max value
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      minY: 0,
                      maxY: maxYValue,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is AnalyticFoodError) {
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