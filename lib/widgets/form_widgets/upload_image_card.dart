import 'package:flutter/material.dart';

class UploadImageCard extends StatefulWidget {
  const UploadImageCard({super.key});

  @override
  State<UploadImageCard> createState() => UploadImageCardState();
}

class UploadImageCardState extends State<UploadImageCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        height: 200,
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }
}
