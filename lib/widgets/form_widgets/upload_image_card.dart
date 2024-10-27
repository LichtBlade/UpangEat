import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageCard extends StatefulWidget {
  final String? imageUrl;

  const UploadImageCard({super.key, this.imageUrl});

  @override
  State<UploadImageCard> createState() => UploadImageCardState();
}

class UploadImageCardState extends State<UploadImageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          height: 200,
          width: 500,
          child: Center(child: _returnImageUrl()),
        ),
      ),
    );
  }

  Widget _returnImageUrl() {
    print("${widget.imageUrl} this is from upload card");
    return widget.imageUrl != null
        ? Image.network(
            widget.imageUrl!,
            errorBuilder: (context, error, stackTrace) {
              print(error.toString());
              return const Icon(Icons.image);
            },
          )
        : const Icon(Icons.image);
  }
}
