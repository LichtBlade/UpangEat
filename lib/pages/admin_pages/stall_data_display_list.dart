import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';

class StallDataDisplayList extends StatefulWidget {
  const StallDataDisplayList({super.key});

  @override
  State<StallDataDisplayList> createState() => _StallDataDisplayListState();
}

class _StallDataDisplayListState extends State<StallDataDisplayList> {

  @override
  void initState() {
    super.initState();
    context.read<StallBloc>().add(LoadStalls());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<StallBloc, StallState>(
        builder: (context, state) {
          if (state is StallLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StallLoaded) {
            final stalls = state.stalls;
            return stalls.isNotEmpty
                ? Expanded(
                    child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: stalls.length,
                      itemBuilder: (context, index) {
                        return const Icon(Icons.store_mall_directory);
                      },
                    ),
                  ))
                : const Center(
                    child: Text('No Data'),
                  );
          }
          return const Text('Unexpected data');
        },
      ),
    );
  }
}
