// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upang_eat/bloc/food_bloc/food_bloc.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/services/storage_service.dart';
import 'package:upang_eat/widgets/form_widgets/upload_image_card.dart';

class SellerCenterProductForm extends StatefulWidget {
  final int stallId;
  final bool? isUpdate;
  final FoodModel? food;

  const SellerCenterProductForm({
    super.key,
    required this.stallId,
    this.isUpdate = false,
    this.food = const FoodModel(
        foodItemId: 0,
        stallId: 0,
        itemName: "",
        price: 0,
        isAvailable: true,
        isBreakfast: false,
        isLunch: false,
        isMerienda: true,
        imageUrl: "",
        description: "",
        stallName: "",
        trayId: 0,
        trayQuantity: 0),
  });

  @override
  State<SellerCenterProductForm> createState() =>
      _SellerCenterProductFormState();
}

class _SellerCenterProductFormState extends State<SellerCenterProductForm> {
  XFile? _selectedImage;
  String _selectedType = 'Breakfast';
  String? _imageUrl;

  final _formKey = GlobalKey<FormState>();

  final _storageService = StorageService();

  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _category = TextEditingController();
  bool _isActive = false;
  bool _uploadButtonIsActive = true;

  @override
  void initState() {
    _isActive = widget.food?.isAvailable ?? true;

    _imageUrl = widget.food!.imageUrl;
    _uploadButtonIsActive = widget.isUpdate! ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Food: ${widget.food}");
    print("IsUpdate: ${widget.isUpdate}");
    _itemName.text = widget.food!.itemName;
    _description.text = widget.food!.description!;
    _price.text = widget.food!.price.toString();
    _selectedType = switch ((
      widget.food!.isBreakfast,
      widget.food!.isLunch,
      widget.food!.isMerienda
    )) {
      (true, false, false) => 'Breakfast',
      (false, true, false) => 'Lunch',
      (false, false, true) => 'Merienda',
      _ => 'Unknown', // Handle other cases if needed
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        centerTitle: true,
        title: const Text(
          'Boss Sisig',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.isUpdate!
                      ? context.read<FoodBloc>().add(UpdateFood(
                          id: widget.food!.foodItemId,
                          stallId: widget.stallId,
                          itemName: _itemName.text,
                          description: _description.text,
                          price: int.parse(_price.text),
                          imageURL: _imageUrl,
                          isAvailable: _isActive,
                          isBreakfast:
                              _selectedType == 'Breakfast' ? true : false,
                          isLunch: _selectedType == 'Lunch' ? true : false,
                          isMerienda:
                              _selectedType == 'Merienda' ? true : false))
                      : context.read<FoodBloc>().add(CreateFood(
                          stallId: widget.stallId,
                          itemName: _itemName.text,
                          description: _description.text,
                          price: int.parse(_price.text),
                          imageURL: _imageUrl,
                          isAvailable: _isActive,
                          isBreakfast:
                              _selectedType == 'Breakfast' ? true : false,
                          isLunch: _selectedType == 'Lunch' ? true : false,
                          isMerienda:
                              _selectedType == 'Merienda' ? true : false));
                }
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocListener<FoodBloc, FoodState>(
        listener: (context, state) {
          if (state is FoodLoading) {
            print("Loading");
          } else if (state is FoodUpdated) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Product Updated Successfully!'),
                ),
              );
            Navigator.pop(context);
          } else if (state is FoodAdded) {
            print("Loaded");

            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Product Created Successfully!'),
                ),
              );
            Navigator.pop(context);
          } else if (state is FoodError) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error in making product, ${state.message}'),
                ),
              );
            print(state.message);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _titleText('Availability'),
                  Switch(
                    value: _isActive,
                    onChanged: (bool value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Product Name
                  _titleText('Name'),
                  TextFormField(
                      controller: _itemName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      }),

                  // Price
                  _titleText('Price'),
                  TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
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
                  _titleText('Type'),
                  StatefulBuilder(
                    builder: (context, setState){
                  return Row(
                    children: [
                      _buildRadioButton(setState, 'Breakfast'),
                      _buildRadioButton(setState, 'Lunch'),
                      _buildRadioButton(setState, 'Merienda')
                    ],
                  );
                }
          ),
                  _titleText('Category'),
                  TextFormField(
                    controller: _category,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                  

                  //Description
                  _titleText('Description'),
                  TextFormField(
                    controller: _description,
                    maxLines: null,
                    maxLength: 300,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                  ),

                  //Image
                  _titleText('Image'),
                  StatefulBuilder(
                    builder: (context, setState){
                  return Column(
                    children: [
                      UploadImageCard(
                        imageUrl: _imageUrl,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: _uploadButtonIsActive
                                ? () async {
                                    _pickImageFromGallery(setState);
                                  }
                                : null,
                            child: const Row(
                              children: [
                                Icon(Icons.add),
                                Text('Add Image'),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: !_uploadButtonIsActive
                                ? () => _removeImage(setState)
                                : null,
                            child: const Row(
                              children: [
                                Icon(Icons.remove),
                                Text('Remove Image'),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                    }
                  )
                ],
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

  Widget _buildRadioButton(StateSetter setState, String meal) {
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

  // Image picker
  Future<void> _pickImageFromGallery(StateSetter setState) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _selectedImage = image;
      _uploadButtonIsActive = false;
    });

    // Upload image right after selecting
    _uploadFoodImage(setState);
  }

  Future<void> _uploadFoodImage(StateSetter setState) async {
    try {
      if (_selectedImage == null) return;

      final String? uploadedImageurl =
          await _storageService.uploadImage('food/', _selectedImage);

      if (uploadedImageurl == null) return;

      // Update _imageUrl after uploading
      setState(() {
        _imageUrl = uploadedImageurl;
      });

          // widget.isUpdate!
          //       ? context.read<FoodBloc>().add(UpdateFood(
          //           id: widget.food!.foodItemId,
          //           stallId: widget.stallId,
          //           itemName: _itemName.text,
          //           description: _description.text,
          //           price: int.parse(_price.text),
          //           imageURL: _imageUrl!, // Now this will have the correct URL
          //           isAvailable: _isActive,
          //           isBreakfast: _selectedType == 'Breakfast' ? true : false,
          //           isLunch: _selectedType == 'Lunch' ? true : false,
          //           isMerienda: _selectedType == 'Merienda' ? true : false))
          //       : context.read<FoodBloc>().add(CreateFood(
          //           stallId: widget.stallId,
          //           itemName: _itemName.text,
          //           description: _description.text,
          //           price: int.parse(_price.text),
          //           imageURL: _imageUrl!, // Now this will have the correct URL
          //           isAvailable: _isActive,
          //           isBreakfast: _selectedType == 'Breakfast' ? true : false,
          //           isLunch: _selectedType == 'Lunch' ? true : false,
          //           isMerienda: _selectedType == 'Merienda' ? true : false));

    } catch (e) {
      throw Exception(e);
    }
  }

  void _removeImage(StateSetter setState) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Remove Image"),
          content: const Text("Are you sure you want to remove this image?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); 

                await _storageService.deleteImage(_imageUrl!);

                // fix for add button unclickable after removing image
                setState(() {
                  _imageUrl = null; 
                  _selectedImage = null;
                  _uploadButtonIsActive = true; 
                });
              },
              child: const Text("Remove"),
            ),
          ],
        );
      },
    );
  }
}
