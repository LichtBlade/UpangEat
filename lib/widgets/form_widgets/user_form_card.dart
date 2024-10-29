import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/create_user/create_user_bloc.dart';
import 'package:upang_eat/repositories/user_repository_impl.dart';
import 'package:upang_eat/widgets/form_widgets/create_form_input_field.dart';

import '../../pages/admin_pages/admin_dashboard.dart';

class IpAddress {
  static String get ipAddress => "http://192.168.100.203:3000";
}

class UserFormCard extends StatefulWidget {
  const UserFormCard({super.key});

  @override
  State<UserFormCard> createState() => _UserFormCardState();
}

class _UserFormCardState extends State<UserFormCard> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  String? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUserBloc(
        UserRepositoryImpl(baseUrl: IpAddress.ipAddress),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            elevation: 4.0, // Adds shadow to the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Inside padding of the card
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 18.0),
                      child: Text(
                        'Create User',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CreateFormInputField(
                      title: 'First name',
                      controller: _firstNameController,
                    ),
                    CreateFormInputField(
                      title: 'Last Name',
                      controller: _lastNameController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _studentIdController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          labelText: 'Student ID',
                          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                          hintText: '03-2223-******',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid Student ID';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                          hintText: 'john.doe@example.com',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          labelText: 'Password',
                          suffixIcon: const Icon(Icons.visibility),
                          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: 
                      TextFormField(
                        controller: _mobileController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          labelText: 'Mobile #',
                          prefixIcon: const Icon(Icons.phone),
                          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                          hintText: '+63 9**-***-****',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 10) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectedUserType,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          labelText: 'User Type',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text('Admin'),
                          ),
                          DropdownMenuItem(
                            value: 'user',
                            child: Text('User'),
                          ),
                          DropdownMenuItem(
                            value: 'stall_owner',
                            child: Text('Stall Owner'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a user type';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<CreateUserBloc>().add(
                                  SubmitUserFormEvent(
                                    firstName: _firstNameController.text.trim(),
                                    lastName: _lastNameController.text.trim(),
                                    studentId: _studentIdController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    mobile: _mobileController.text.trim(),
                                    userType: _selectedUserType!,
                                  ),
                                );
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AdminDashboard()), // Replace with your AdminDashboard widget
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC5473D), // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),

                            child: const Text('Create Account'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
