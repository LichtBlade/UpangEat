import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:upang_eat/Widgets/stalls_stall_card.dart";
import "package:upang_eat/repositories/stall_repository_impl.dart";

import "../bloc/stall_bloc/stall_bloc.dart";
import "../fake_data.dart";

class Stalls extends StatefulWidget {
  const Stalls({super.key});

  @override
  State<Stalls> createState() => _StallsState();
}

class _StallsState extends State<Stalls> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StallBloc(StallRepositoryImpl())..add(LoadStalls()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stalls"),
        ),
        body: Center(
          child: SizedBox(
            width: 350,
            child: BlocBuilder<StallBloc, StallState>(
              builder: (context, state) {
                if (state is StallLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                    Skeletonizer(
                    child: ListView.builder(itemCount: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return StallsStallCard(stall: FakeData.fakeStall);
                        }),
                  );
                } else if (state is StallLoaded) {
                  final stallData = state.stalls;
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      scrollDirection: Axis.vertical,
                      itemCount: stallData.length,
                      itemBuilder: (context, index) {
                        final stall = stallData[index];
                        return StallsStallCard(stall: stall);
                      });
                } else if (state is StallError) {
                  return Text("Error: ${state.message}");
                } else {
                  return const Text("Unexpected state}");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}