// TODO: make the actual form
import 'package:flutter/material.dart';

class CreateStallForm extends StatefulWidget {
  const CreateStallForm({super.key});

  @override
  State<CreateStallForm> createState() => _CreateStallFormState();
}

class _CreateStallFormState extends State<CreateStallForm> {

  final _formkey = GlobalKey<FormState>();

  List<String> titles = [
    'Stall Name',
    'Owner ID',
    'Description',
    'Image'
    'Image Banner'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Stall'),
          backgroundColor: const Color.fromARGB(255, 255, 169, 186),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              onChanged: () {
                setState(() {
                  Form.of(primaryFocus!.context!).save;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(6, (int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          onSaved: (String? value) {
                            if (value != null) {
                              titles[index] = value;
                            }
                          },
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ));
  }

  Widget createTextFormField(String title) {
    return TextFormField(
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: title),
    );
  }
}
