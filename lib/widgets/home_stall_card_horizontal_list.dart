import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/widgets/home_stall_card.dart';

import '../bloc/stall_bloc/stall_bloc.dart';

class HomeStallCardHorizontalList extends StatefulWidget {

  const HomeStallCardHorizontalList({super.key});

  @override
  State<HomeStallCardHorizontalList> createState() => _HomeStallCardHorizontalListState();
}

class _HomeStallCardHorizontalListState extends State<HomeStallCardHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      child: BlocBuilder<StallBloc, StallState>(
        builder: (context, state) {
          if (state is StallInitial) {
            context.read<StallBloc>().add(LoadStalls());
            return const CircularProgressIndicator();
          } else if (state is StallLoading) {
            return const CircularProgressIndicator();
          } else if (state is StallLoaded) {
            final stallData = state.stalls;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                scrollDirection: Axis.horizontal,
                itemCount: stallData.length,
                itemBuilder: (context, index) {
                  final stall = stallData[index];
                  return HomeStallCard(stall: stall);
                });
          } else if (state is StallError) {
            return Text("Error: ${state.message}");
          } else {
            return const Text("Unexpected state}");
          }
        },
      ),
    );
  }
}
