import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/pages/seller_center/seller_center.dart';
import 'package:upang_eat/user_data.dart';

import '../../bloc/stall_bloc/stall_bloc.dart';
import '../../models/user_model.dart';
import '../../services/storage_service.dart';

class StallProfile extends StatefulWidget {
  const StallProfile({super.key});

  @override
  State<StallProfile> createState() => _StallProfileState();
}

class _StallProfileState extends State<StallProfile> {
  final TextEditingController _stallName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  XFile? _profileImage;
  XFile? _bannerImage;
  bool isAvailable = false;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _storageService = StorageService();

  @override
  void initState() {
    context.read<StallBloc>().add(LoadSingleStall(globalUserData!.stallId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StallBloc, StallState>(
      listener: (context, state) {
        if (state is SingleStallLoaded) {
          _stallName.text = state.stall.stallName;
          _description.text = state.stall.description!;
        }
      },
      child: BlocBuilder<StallBloc, StallState>(
        builder: (context, state) {
          if (state is StallLoading) {
            return Scaffold(
                appBar: _appBar(null),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          } else if (state is SingleStallLoaded) {
            return PopScope(
              canPop: false,
              onPopInvoked: (isPop){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SellerCenter()),
                );
              },
              child: Scaffold(
                appBar: _appBar(state.stall),
                body: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        _stallNameField(),
                        const SizedBox(
                          height: 16,
                        ),
                        _descriptionField(),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Profile Image",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        _uploadProfile(state.stall.imageUrl!),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Banner Image",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        _uploadBanner(state.stall.imageBannerUrl!)
                      ],
                    )),
              ),
            );
          } else {
            return const Text("Unexpected State");
          }
        },
      ),
    );
  }

  PreferredSizeWidget _appBar(Stall? stall) {
    return AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          stall != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Confirm Update"),
                              content: const Text("Are you sure you want to update your stall profile?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true; // Start loading
                                    });
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false, // Prevent dismissal by tapping outside
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: Row(
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(width: 20),
                                              Text("Uploading..."),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    String? profilePath;
                                    String? bannerPath;
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        if (_profileImage != null) {
                                          profilePath = await _storageService.uploadImage('stalls/profiles', _profileImage);
                                        } else {
                                          profilePath = stall.imageUrl!;
                                        }
                                        if (_bannerImage != null) {
                                          bannerPath = await _storageService.uploadImage('stalls/banners', _bannerImage);
                                        } else {
                                          bannerPath = stall.imageBannerUrl!;
                                        }
                                      } catch (error){
                                        print(error);
                                      }
                                      print("Profile Path: $profilePath");
                                      print("Banner Path: $bannerPath");
                                      context.read<StallBloc>().add(UpdateStall(Stall(
                                          stallId: stall.stallId,
                                          stallName: _stallName.text,
                                          ownerId: stall.ownerId,
                                          isActive: stall.isActive,
                                          contactNumber: stall.contactNumber,
                                          description: _description.text,
                                          imageUrl: profilePath,
                                          imageBannerUrl: bannerPath)));

                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('stallName', _stallName.text);
                                      final userData = UserModel(userId: prefs.getInt("userId")!, firstName: prefs.getString("firstName")!, lastName: prefs.getString("lastName")!, email: prefs.getString("email")!,
                                          phoneNumber: prefs.getString("phoneNumber")!, userType: prefs.getString("userType")!, stallId: prefs.getInt("stallId")!, stallName: _stallName.text);
                                      globalUserData = userData;

                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: const Text("Your profile is successfully updated"),
                                            title: const Text("Success"),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }, child: const Text("Ok"))
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    // Navigator.of(context).pop();
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ))
              : const SizedBox.shrink()
        ],
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SellerCenter(),
              ),
            );;
          },
          color: Colors.white,
        ));
  }

  Widget _stallNameField() {
    return TextFormField(
      maxLength: 128,
      maxLines: 1,
      controller: _stallName,
      decoration: const InputDecoration(
        labelText: 'Stall Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a stall name';
        } else if (value.length < 4) {
          return 'Stall name should be more than 3 characters';
        }
        return null;
      },
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      controller: _description,
      maxLength: 300,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _uploadProfile(String path) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          setState(() {
            _profileImage = image;
          });
        }
      },
      child: _profileImage == null
          ? (path.isNotEmpty)
              ? _ImageFromFirebase(
                  path: path,
                )
              : const _UploadBox(message: "Upload profile image here")
          : _UploadedImage(
              path: _profileImage!.path,
            ),
    );
  }

  Widget _uploadBanner(String path) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          setState(() {
            _bannerImage = image;
          });
        }
      },
      child: _bannerImage == null
          ? (path.isNotEmpty)
              ? _ImageFromFirebase(
                  path: path,
                )
              : const _UploadBox(message: "Upload banner image here")
          : _UploadedImage(
              path: _bannerImage!.path,
            ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  final String message;

  const _UploadBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12.0),
              child: const Icon(
                Icons.file_upload_outlined,
                size: 32,
                color: Colors.grey,
              ),
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}

class _ImageFromFirebase extends StatelessWidget {
  final String path;
  const _ImageFromFirebase({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Colors.black12,
        ),
        child: Image.network(
          path,
          height: 250,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
              ),
            );
          },
        ));
  }
}

class _UploadedImage extends StatelessWidget {
  final String path;
  const _UploadedImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.black12,
      ),
      child: Image.file(File(path), frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return child;
        }
      }),
    );
  }
}
