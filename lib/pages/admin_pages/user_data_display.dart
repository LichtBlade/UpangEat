import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/create_user/create_user_bloc.dart';
import 'package:upang_eat/models/user_model.dart';

class UserDataDisplay extends StatefulWidget {
  const UserDataDisplay({super.key});

  @override
  State<UserDataDisplay> createState() => _UserDataDisplayState();
}

class _UserDataDisplayState extends State<UserDataDisplay> {
  @override
  void initState() {
    super.initState();
    context.read<CreateUserBloc>().add(CreateUserLoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CreateUserBloc, CreateUserState>(
        builder: (context, state) {
          if (state is CreateUserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CreateUserLoaded) {
            final users = state.users;
            return users.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return _BuildUserCard(userModel: user);
                          },
                        ),
                      ))
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

class _BuildUserCard extends StatelessWidget {
  final UserModel userModel;

  const _BuildUserCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userModel.firstName}, ${userModel.lastName}  ',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    userModel.email,
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
