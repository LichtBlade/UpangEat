import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/pages/order_status.dart';

import '../bloc/order_bloc/order_bloc.dart';

class PaymentProcessing extends StatefulWidget {
  const PaymentProcessing({super.key});

  @override
  State<PaymentProcessing> createState() => _PaymentProcessingState();
}

class _PaymentProcessingState extends State<PaymentProcessing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderAdded){
            Future.delayed(const Duration(milliseconds: 2000), () {
              Navigator.pop(context);
              Navigator.pop(context);

            }
            );
          }else if (state is OrderLoaded){
            print("ORDERS ${state.order} ORDERS");
            Future.delayed(const Duration(milliseconds: 2000), () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderStatus(orders: state.order,)));

            }
            );
          }
        },
        child: Center(
          child: SizedBox(
            height: 350,
            width: 350,
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(
                    child: Column(children: [
                      CircularProgressIndicator(),
                      Text("Processing payment please wait.")
                    ],),
                  );
                } else if (state is OrderAdded || state is OrderLoaded) {
                  return const Center(child: Text("Woohoo! Payment confirmed. You're one step closer to deliciousness!"));
                } else if (state is OrderError) {
                  return Text("Error: ${state.message}");
                } else {
                  return const Text("Unexpected statesss");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}