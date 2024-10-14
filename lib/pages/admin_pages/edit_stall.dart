import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_bloc.dart';
import 'package:upang_eat/bloc/admin_bloc/admin_event.dart';
import 'package:upang_eat/models/stall_model.dart';

class EditStallScreen extends StatefulWidget {
  final Stall stall;

  const EditStallScreen({Key? key, required this.stall}):
    super(key: key);

  @override
  State<EditStallScreen> createState() => _EditStallScreenState();
}

class _EditStallScreenState extends State<EditStallScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _stallNameController;
  late TextEditingController _ownerIdController;
  late TextEditingController _contactNoController;
  late TextEditingController _descriptionController;
  bool _isActive = false; 

  @override
  void initState() {
    super.initState();

    _stallNameController = TextEditingController(text: widget.stall.stallName);
    _ownerIdController = TextEditingController(text: widget.stall.ownerId.toString());
    _contactNoController = TextEditingController(text: widget.stall.contactNumber?.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.stall.description ?? '');
    _isActive = widget.stall.isActive; 
  }

  @override
  void dispose() {
    _stallNameController.dispose();
    _ownerIdController.dispose();
    _contactNoController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stall: ${widget.stall.stallName}'),
        backgroundColor: const Color.fromARGB(255, 255, 169, 186),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              const SizedBox(height: 16.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Active?',
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32.0),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AdminBloc>().add(
                      UpdateStallEvent(
                        stallId: widget.stall.stallId,
                        stallName: _stallNameController.text.trim(),
                        ownerId: int.parse(_ownerIdController.text.trim()),
                        contactNumber: int.parse(_contactNoController.text.trim()),
                        description: _descriptionController.text.trim(),
                        isActive: _isActive,
                      ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Stall updated successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 169, 186),
                  ),
                  child: const Text('Update Stall'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
