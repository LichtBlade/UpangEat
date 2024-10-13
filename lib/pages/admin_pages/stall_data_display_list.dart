import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/stall_bloc/stall_bloc.dart';
import 'package:upang_eat/models/stall_model.dart';

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
                ? Column(
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: stalls.length,
                          itemBuilder: (context, index) {
                            final stall = stalls[index];
                            return _BuildStallCard(
                              stall: stall,
                            );
                          },
                        ),
                      )),
                    ],
                  )
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

class _BuildStallCard extends StatelessWidget {
  final Stall stall;

  const _BuildStallCard({super.key, required this.stall});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              height: 65,
              width: 65,
              child: Image.asset(
                stall.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stall.stallName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    stall.isActive ? 'Active' : 'Inactive',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                      ),
                    ),
                    PopupMenuItem(
                      child: const ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        title: Text('Delete'),
                      ),
                    )
                  ])
        ],
      ),
    );
  }
}
