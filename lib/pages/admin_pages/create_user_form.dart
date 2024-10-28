import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/form_widgets/user_form_card.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Canceled')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form content
          const UserFormCard(),
        ],
      ),
    );
  }

  Widget labelText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    );
  }
}
