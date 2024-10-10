import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Status"),),
      body: const Stack(
        children: [
          StepProgressIndicator(
            totalSteps: 10,
            currentStep: 6,
            selectedColor: Colors.red,
            unselectedColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}
