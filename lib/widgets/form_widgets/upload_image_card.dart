import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class UploadImageCard extends StatefulWidget {
  final Uint8List? selectedImage;

  const UploadImageCard({super.key, this.selectedImage});

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
            child: Center(
              child: widget.selectedImage != null
                  ? Image.memory(widget.selectedImage!)
                  : const Icon(Icons.image),
            )),
      ),
    );
  }
}
