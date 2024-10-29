import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_event.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_state.dart';
import 'package:upang_eat/pages/admin_pages/admin_dashboard.dart';
import 'package:upang_eat/repositories/stall_repository_impl.dart';

class CreateStallForm extends StatefulWidget {
  const CreateStallForm({super.key});

  @override
  State<CreateStallForm> createState() => _CreateStallFormState();
}

class _CreateStallFormState extends State<CreateStallForm> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _stallNameController = TextEditingController();
  final TextEditingController _ownerIdController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(StallRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Stall'),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _stallNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Stall Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter stall name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _ownerIdController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Owner User ID',
                            ),
                            keyboardType: TextInputType.number, 
                                inputFormatters:
                                <TextInputFormatter>
                                  [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Owner User ID';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _contactNoController,
                            decoration:
                                const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Contact No.',
                              ),
                                keyboardType: TextInputType.number, 
                                inputFormatters:
                                <TextInputFormatter>
                                  [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Contact No.';
                                  }
                                  return null;
                                },
                              ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description (Optional)',
                              hintText: 'Brief description of the stall',
                            ),
                            maxLines: 4,
                          ),
                          const SizedBox(height: 32.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Active',
                                style: TextStyle(fontSize: 16),
                              ),
                              Switch(
                                value: _isActive,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isActive = value;
                                  });
                                },
                                activeColor: const Color(0xFFc5473d),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  context.read<AdminBloc>().add(
                                    CreateStallEvent(
                                      stallName: _stallNameController.text.trim(),
                                      ownerId: int.parse(_ownerIdController.text.trim()),
                                      contactNumber: int.parse(_contactNoController.text.trim()),
                                      description: _descriptionController.text.trim(),
                                      isActive: _isActive,
                                    ),
                                  );
                                  Navigator.pop(
                                    context,
                                    MaterialPageRoute(builder: (context) => const AdminDashboard()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFc5473d),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              ),
                              child: const Text('Create Stall'),
                            ),
                          ),
                          BlocListener<AdminBloc, AdminState>(
                            listener: (context, state) {
                              if (state is AdminLoading) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Creating stall...')),
                                );
                              } else if (state is AdminSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Stall created successfully!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const AdminDashboard(),
                                  ),
                                );
                              } else if (state is AdminFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: ${state.error}')),
                                );
                              }
                            },
                            child: const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
