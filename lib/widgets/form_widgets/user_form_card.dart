import 'package:flutter/material.dart';
import 'package:upang_eat/widgets/form_widgets/create_form_input_field.dart';

class UserFormCard extends StatefulWidget {
  const UserFormCard({super.key});

  @override
  State<UserFormCard> createState() => _UserFormCardState();
}

class _UserFormCardState extends State<UserFormCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 18.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      const CreateFormInputField(
                        title: 'First name',
                      ),
                      const CreateFormInputField(
                        title: 'Last Name',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            labelText: 'Student ID',
                            hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                            hintText: '03-2223-******',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                              hintText: 'joan.collins.up@phinmaed.com'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              labelText: 'Password',
                              suffixIcon: const Icon(Icons.visibility),
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w300)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              labelText: 'Mobile #',
                              prefixIcon: const Icon(Icons.phone),
                              hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                              hintText: '+63 9**-***-****'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: FilledButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 255, 169, 186),
                          ),
                        ),
                        child: const Text('Create Account'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
