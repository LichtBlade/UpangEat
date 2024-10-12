import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_event.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_state.dart';
import 'package:upang_eat/repositories/admin_repository_impl.dart';
import 'package:upang_eat/pages/admin_pages/admin_dashboard.dart'; 

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(AdminRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Stall'),
          backgroundColor: const Color.fromARGB(255, 255, 169, 186),
        ),
        body: SingleChildScrollView(
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

                  // Owner User ID Field
                  TextFormField(
                    controller: _ownerIdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owner User ID',
                    ),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact No.',
                    ),
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

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          context.read<AdminBloc>().add(
                            CreateStallEvent(
                              stallName: _stallNameController.text.trim(),
                              description: _descriptionController.text.trim(),
                              ownerId: _ownerIdController.text.trim(),
                              contactNo: _contactNoController.text.trim(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
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
    );
  }
}
