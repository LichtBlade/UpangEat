import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:upang_eat/Pages/stall_information.dart';
import 'package:upang_eat/main.dart';
import 'package:upang_eat/models/stall_model.dart';

import 'package:transparent_image/transparent_image.dart'; 

class HomeStallCard extends StatefulWidget {
  final Stall stall;
  const HomeStallCard({super.key, required this.stall});

  @override
  State<HomeStallCard> createState() => _HomeStallCardState();
}

class _HomeStallCardState extends State<HomeStallCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, top: 8, bottom: 16, right: 6.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => StallInformation(stall: widget.stall)));
        },
        child: Card.filled(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Column(children: [
              SizedBox( 
                height: 100,
                width: 130,
                child: FadeInImage.memoryNetwork( 
                  placeholder: kTransparentImage, 
                  image: widget.stall.imageUrl!,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      const Center( 
                        child: Text(
                          "No Image Uploaded",
                          style: TextStyle(
                            fontSize: 10, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                ),
              ),
              SizedBox(
                width: 110,
                child:
                Center(child: Text(widget.stall.stallName, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600),)),
              ),
              const SizedBox(height: 4,)
            ]),
          ),
        ),
      ),
    );
  }
}