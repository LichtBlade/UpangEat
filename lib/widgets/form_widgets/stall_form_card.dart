import 'package:flutter/material.dart';

class StallFormCard extends StatefulWidget {
  const StallFormCard({super.key});

  @override
  State<StallFormCard> createState() => _StallFormCardState();
}

class _StallFormCardState extends State<StallFormCard> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _stallNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                  'Create Stall',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _stallNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        labelText: 'Stall Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the stall name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),

                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        labelText: 'Description (Optional)',
                        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                        hintText: 'Brief description of the stall',
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Stall Name: ${_stallNameController.text}');
                            print('Description: ${_descriptionController.text}');
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Stall Created Successfully')),
                            );
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 169, 186),
                          ),
                        ),
                        child: const Text('Create Stall'),
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
