import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:upang_eat/Pages/stall_information.dart';
import 'package:upang_eat/main.dart';
import 'package:upang_eat/models/stall_model.dart';

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
              Image.network("${IpAddress.ipAddress}/uploads/profile_${widget.stall.stallId}.jpg",
                  height: 100,
                  width: 130,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Text('Error loading image');
                  },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (frame == null) {
                    return Skeletonizer(
                      child: Image.asset("assets/foods/1_1.jpg",
                        height: 100,
                        width: 130,
                        fit: BoxFit.cover,),
                    );
                  } else {
                    return child;
                  }
                },),
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