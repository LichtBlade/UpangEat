
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:upang_eat/bloc/tray_bloc/tray_bloc.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:skeletonizer/skeletonizer.dart";
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

//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: BlocBuilder<FoodBloc, FoodState>(
//           builder: (context, state) {
//             int productCount = 0;
//             if (state is FoodLoaded) {
//               productCount = state.foods.length;
//             }
//             return Text("Tray ($productCount)");
//           },
//         ),
//       ),
//       child: SafeArea(
//         child: BlocListener<TrayBloc, TrayState>(
//           listener: (context, state) {
//             if (state is TrayItemRemoved) {
//               context.read<FoodBloc>().add(LoadFoodTray(widget.id));
//             } else if (state is TrayError) {
//               CupertinoAlertDialog alert = CupertinoAlertDialog(
//                 title: const Text('Error'),
//                 content: Text(state.message),
//                 actions: [
//                   CupertinoDialogAction(
//                     child: const Text('OK'),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               );
//               showCupertinoDialog(context: context, builder: (context) => alert);
//             }
//           },
//           child: BlocBuilder<FoodBloc, FoodState>(
//             builder: (context, state) {
//               if (state is FoodLoading) {
//                 return Skeletonizer(
//                   child: ListView.builder(
//                     itemCount: 8,
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     itemBuilder: (context, index) {
//                       return TrayCard(food: FakeData.fakeFood);
//                     },
//                   ),
//                 );
//               } else if (state is FoodLoaded) {
//                 final foods = state.foods;
//                 return foods.isNotEmpty
//                     ? ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   itemCount: foods.length,
//                   itemBuilder: (context, index) {
//                     final food = foods[index];
//                     return TrayCard(food: food);
//                   },
//                 )
//                     : const Center(child: Text("Empty"));
//               } else if (state is FoodError) {
//                 return Center(child: Text(state.message));
//               } else {
//                 return const Center(child: Text("Unexpected state"));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

    return Scaffold(
      appBar: const _AppBar(),
      body: BlocListener<TrayBloc, TrayState>(
        listener: (context, state) {
          if (state is TrayItemRemoved) {
            context.read<FoodBloc>().add(LoadFoodTray(widget.id));
          } else if (state is TrayError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Stack(children: [
          const Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: _TrayBlocBuilder(),
          ),
          Positioned(
            bottom: 16,
            left: 24,
            right: 24,
            child: FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(8.0),
                minimumSize: WidgetStateProperty.all(const Size(100, 50)),
              ),
              child: const Text("Checkout"),
            ),
          )
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
      title: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoaded) {
            _productCount = state.foods.length;
          }
          return Text("Tray ($_productCount)");
        },
      ),
    );
  }
}

class _TrayBlocBuilder extends StatelessWidget {
  const _TrayBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is FoodLoading) {
          return Skeletonizer(
            child: ListView.builder(
                itemCount: 8,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemBuilder: (context, index) {
                  return TrayCard(food: FakeData.fakeFood);
                }),
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
                  })
              : const Text("Empty");
        } else if (state is FoodError) {
          return Text(state.message);
        } else {
          return const Text("Unexpected state");
        }
      },
    );
  }
}
