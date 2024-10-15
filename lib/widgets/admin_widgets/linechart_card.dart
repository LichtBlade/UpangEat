import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upang_eat/models/transaction_model.dart';
import 'package:upang_eat/repositories/transaction_repository_impl.dart';
import 'customcard.dart';

class LineChartCard extends StatefulWidget {
  const LineChartCard({super.key});

  @override
  _LineChartCardState createState() => _LineChartCardState();
}

class _LineChartCardState extends State<LineChartCard> {
  List<TransactionModel> transactions = [];
  final TransactionRepositoryImpl transactionRepo = TransactionRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      List<TransactionModel> fetchedTransactions = await transactionRepo.fetchTransaction();
      setState(() {
        transactions = fetchedTransactions;
      });
    } catch (e) {
      print("Failed to load transactions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    DateFormat inputDateFormat = DateFormat('MM/dd/yy HH:mm');
    DateFormat outputDateFormat = DateFormat('MM/dd');

    // Sort transactions by date
    transactions.sort((a, b) {
      DateTime dateA = inputDateFormat.parse(a.transactionDate!);
      DateTime dateB = inputDateFormat.parse(b.transactionDate!);
      return dateA.compareTo(dateB);
    });

    // Extract the last 7 transactions
    int numOfDays = 7;
    List<TransactionModel> recentTransactions = transactions.length > numOfDays
        ? transactions.sublist(transactions.length - numOfDays)
        : transactions;

    // Generate FlSpot data for chart
    List<FlSpot> spots = List.generate(recentTransactions.length, (index) {
      return FlSpot(index.toDouble(), recentTransactions[index].amount.toDouble());
    });

    // Determine max Y value
    double maxY = recentTransactions.isNotEmpty
        ? recentTransactions.map((e) => e.amount).reduce((a, b) => a > b ? a : b).toDouble()
        : 100;
    double yInterval = maxY / 10;

    // Generate date labels for X axis
    List<String> dateLabels = recentTransactions.map((transaction) {
      try {
        DateTime parsedDate = inputDateFormat.parse(transaction.transactionDate!);
        return outputDateFormat.format(parsedDate);
      } catch (e) {
        print("Error parsing date: ${transaction.transactionDate}");
        return '';
      }
    }).toList();

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transactions Overview (Last 7 Days)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 10,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(handleBuiltInTouches: true),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < dateLabels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              dateLabels[index],
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: (double value, TitleMeta meta) {
                        int roundedValue = (value / 100).round() * 100;
                        return Text(
                          roundedValue.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      showTitles: true,
                      interval: yInterval,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    color: Colors.redAccent,
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.redAccent.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                      show: true,
                    ),
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    spots: spots,
                  ),
                ],
                minX: 0,
                maxX: recentTransactions.length.toDouble() - 1,
                minY: 0,
                maxY: maxY,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
