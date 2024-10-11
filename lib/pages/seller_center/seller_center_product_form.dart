// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: implement image input
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/repositories/food_repository_impl.dart';

class SellerCenterProductForm extends StatefulWidget {
  final int stallId;

  const SellerCenterProductForm({
    super.key,
    required this.stallId,
  });

  @override
  State<SellerCenterProductForm> createState() =>
      _SellerCenterProductFormState();
}

class _SellerCenterProductFormState extends State<SellerCenterProductForm> {
  String _selectedType = 'Breakfast';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodBloc(FoodRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 222, 15, 57),
          title: const Center(
            child: Text(
              'Boss Sisig',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Card(
              margin: const EdgeInsets.all(16),
              color: const Color.fromARGB(255, 237, 237, 237),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Food',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Product Name
                    _titleText('Name'),
                    SizedBox(
                      height: 34,
                      child: TextFormField(
                        controller: _itemName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),

                    // Price
                    _titleText('Price'),
                    SizedBox(
                      height: 34,
                      child: TextFormField(
                        controller: _price,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter price';
                          }
                          return null;
                        },
                      ),
                    ),

                    // Radio Button
                    _titleText('Type'),
                    Row(
                      children: [
                        _buildRadioButton('Breakfast'),
                        _buildRadioButton('Lunch'),
                        _buildRadioButton('Merienda')
                      ],
                    ),

                    // Category
                    _titleText('Category:'),
                    SizedBox(
                      height: 34,
                      child: TextFormField(
                        controller: _category,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),

                    //Description
                    _titleText('Description'),
                    SizedBox(
                      height: 200, //     <-- TextField expands to this height.
                      child: TextField(
                        controller: _description,
                        maxLines: null, // Set this
                        expands: true, // and this
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                        ),
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),

                    //Image
                    _titleText('Image'),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.white,
                          height: 200,
                          width: 500,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                            ],
                          )),
                    ),

                    //Footer Buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              elevation: 2.0,
                              backgroundColor:
                                  const Color.fromARGB(255, 222, 15, 57),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<FoodBloc>().add(CreateFood(
                                    stallId: widget.stallId,
                                    itemName: _itemName.text,
                                    description: _description.text,
                                    price: int.parse(_price.text),
                                    imageURL: '',
                                    isAvailable: true,
                                    isBreakfast: _selectedType == 'Breakfast'
                                        ? true
                                        : false,
                                    isLunch:
                                        _selectedType == 'Lunch' ? true : false,
                                    isMerienda: _selectedType == 'Merienda'
                                        ? true
                                        : false));
                              }
                            },
                            child: const Text(
                              'Create Food',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocListener<FoodBloc, FoodState>(
                      listener: (context, state) {
                        if (state is FoodLoading) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Creating Product'),
                            ),
                          );
                        } else if (state is FoodAdded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product Created Successfully!'),
                            ),
                          );
                        } else if (state is FoodError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error in making product'),
                            ),
                          );
                        }
                      },
                      child: Container(),
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

  Widget _titleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildRadioButton(String meal) {
    return Row(
      children: [
        Radio<String>(
          value: meal,
          groupValue: _selectedType,
          onChanged: (String? value) {
            setState(() {
              _selectedType = value!;
            });
          },
        ),
        Text(meal),
      ],
    );
  }
}
