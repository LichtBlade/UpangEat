import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:upang_eat/Widgets/stalls_stall_card.dart";
import "package:upang_eat/bloc/tray_bloc/tray_bloc.dart";
import "package:upang_eat/models/food_model.dart";
import "package:upang_eat/models/order_model.dart";
import "package:upang_eat/models/tray_model.dart";
import "package:upang_eat/pages/payment_processing.dart";
import "package:upang_eat/user_data.dart";

import "../bloc/food_bloc/food_bloc.dart";
import "../bloc/order_bloc/order_bloc.dart";
import "../fake_data.dart";
import "../models/order_item_model.dart";
import "../repositories/tray_repository_impl.dart";
import "../widgets/tray_card.dart";

class Tray extends StatefulWidget {
  final int id;
  const Tray({super.key, required this.id});

  @override
  State<Tray> createState() => _TrayState();
}

class _TrayState extends State<Tray> {
  @override
  void initState() {
    super.initState();
    context.read<TrayBloc>().add(TrayLoadFood(widget.id));
  }

  double convertPhpToEth(double totalPayment) {
    if (globalEthPrice > 0) {
      // Ensure the ETH price is not zero to avoid division by zero
      double ethAmount = totalPayment / globalEthPrice; // Convert PHP to ETH
      return ethAmount; // Return the amount in ETH
    } else {
      print("Error: ETH price is zero or not set.");
      return 0.0; // Return 0.0 if ETH price is not available
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const _AppBar(),
        body: BlocListener<TrayBloc, TrayState>(
          listener: (context, state) {
            if (state is TrayItemsRemoved) {
              context.read<TrayBloc>().add(TrayLoadFood(widget.id));
            } else if (state is TrayFoodLoaded) {
              // context.read<TrayBloc>().add(TrayLoadFood(widget.id));
            } else if (state is TrayError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Stack(children: [
            const Positioned(
              top: 0,
              bottom: 320,
              right: 0,
              left: 0,
              child: _FoodBlocBuilder(),
            ),
            const Positioned(
              bottom: 80,
              left: 24,
              right: 24,
              child: _OrderSummaryAndWallet(),
            ),
            Positioned(
              bottom: 16,
              left: 24,
              right: 24,
              child: FilledButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        final foodState = context.read<TrayBloc>().state;
                        if (foodState is TrayFoodLoaded) {
                          final foods = foodState.foods;
                          final totalAmount = foodState.totalPrice;
                          final convertToEth =
                              convertPhpToEth(totalAmount.toDouble());
                          if (foods.isEmpty) {
                            return AlertDialog(
                                title: const Text("Empty Tray"),
                                content: const Text(
                                    "Your tray is empty. Add some delicious items before proceeding to payment."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ]);
                          }

                          return AlertDialog(
                            title: const Text("Proceed to Payment"),
                            content: Text(
                                "Please review the amount of $convertToEth ETH for your order before confirming payment."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Create a list of OrderItemModel from foods
                                  final orderItems = foods
                                      .map((food) => OrderItemModel(
                                          orderItemId: 0,
                                          itemId: food.foodItemId,
                                          quantity: food.trayQuantity ?? 1,
                                          subtotal: food.price *
                                              (food.trayQuantity ?? 1)))
                                      .toList();

                                  // Create the OrderModel
                                  final order = OrderModel(
                                    orderId: 0,
                                    userId: widget.id,
                                    totalAmount: totalAmount,
                                    items: orderItems,
                                  );
                                  print(order);
                                  context
                                      .read<OrderBloc>()
                                      .add(CreateOrder(order, widget.id));

                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentProcessing()));
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          );
                        } else {
                          print("error: creating order");
                          return AlertDialog(
                              title: const Text("Empty Tray"),
                              content: const Text(
                                  "Your tray is empty. Add some delicious items before proceeding to payment."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ]);
                        }
                      });
                },
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(8.0),
                  minimumSize: WidgetStateProperty.all(const Size(100, 50)),
                ),
                child: const Text("Proceed to Pay"),
              ),
            ),
          ]),
        ),
      );
  }
}

class _AppBar extends StatefulWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  State<_AppBar> createState() => _AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarState extends State<_AppBar> {
  int _productCount = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<TrayBloc, TrayState>(
        builder: (context, state) {
          if (state is TrayFoodLoaded) {
            _productCount = state.foods.length;
          }
          return Text("Tray ($_productCount)");
        },
      ),
    );
  }
}

class _OrderSummaryAndWallet extends StatefulWidget {
  const _OrderSummaryAndWallet({super.key});

  @override
  State<_OrderSummaryAndWallet> createState() => _OrderSummaryAndWalletState();
}

class _OrderSummaryAndWalletState extends State<_OrderSummaryAndWallet> {
  final double ethBalance = globalEthBalance; // Replace with actual ETH balance
  late double phpBalance; // Declare as late
  late String formattedPhpBalance; // Declare as late

  @override
  void initState() {
    super.initState();
    initializeBalances(); // Initialize balances in initState
  }

  void initializeBalances() {
    phpBalance = globalEthBalance * globalEthPrice; // Calculate phpBalance
    formattedPhpBalance = NumberFormat.currency(
      locale: 'en_PH', // For the Philippines locale
      symbol: '₱', // PHP currency symbol
      decimalDigits: 2, // Optional: Set decimal digits
    ).format(phpBalance); // Format phpBalance as currency
  }

  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Wallet Balance",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isSwitch = !isSwitch;
            });
          },
          child: Card.outlined(
            child: SizedBox(
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Image.asset(
                      isSwitch ? "assets/pesosSign.png" : "assets/ethSign.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSwitch
                              ? formattedPhpBalance
                              : "${ethBalance.toStringAsFixed(6)} ETH",
                          maxLines: 1,
                          style: const TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Text(
          "Order Summary",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(
          height: 4,
        ),
        Card.filled(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          color: Colors.black12,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal"),
                    BlocBuilder<TrayBloc, TrayState>(
                      builder: (context, state) {
                        int totalPrice = 0;
                        if (state is TrayFoodLoaded) {
                          totalPrice = state.totalPrice;
                          return Text("₱ $totalPrice");
                        }
                        return Text("₱ $totalPrice");
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Tax(0%)"), Text("₱ 0")],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    BlocBuilder<TrayBloc, TrayState>(
                      builder: (context, state) {
                        int totalPrice = 0;
                        if (state is TrayFoodLoaded) {
                          totalPrice = state.totalPrice;
                          return Text("₱ $totalPrice",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16));
                        } else {
                          return const Text("₱ 0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16));
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FoodBlocBuilder extends StatelessWidget {
  const _FoodBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrayBloc, TrayState>(
      builder: (context, state) {
        if (state is TrayLoading) {
          return Skeletonizer(
            child: ListView.builder(
                itemCount: 8,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemBuilder: (context, index) {
                  return TrayCard(food: FakeData.fakeFood);
                }),
          );
        } else if (state is TrayFoodLoaded) {
          final foods = state.foods;
          print(foods);
          return foods.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return TrayCard(food: food);
                  })
              : Center(child: Image.asset("assets/mingming.png", ),);
        } else if (state is TrayError) {
          return Text(state.message);
        } else {
          return const Text("Unexpected state");
        }
      },
    );
  }
}
