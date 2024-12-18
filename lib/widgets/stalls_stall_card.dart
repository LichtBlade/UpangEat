import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:upang_eat/pages/stall_information.dart';
import 'package:upang_eat/models/stall_model.dart';

import '../main.dart';

class StallsStallCard extends StatelessWidget {
  final Stall stall;

  const StallsStallCard({super.key, required this.stall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => StallInformation(stall: stall)),
          );
        },
        child: Card.filled(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Row(
                    children: [
                      Image.network(
                        stall.imageUrl!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          if (frame == null) {
                            return Skeletonizer(
                              enabled: true,
                              child: Image.asset("assets/foods/1_1.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,),
                            );
                          } else {
                            return child;
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Image.network(
                          stall.imageBannerUrl!,
                          height: 100,
                          fit: BoxFit.cover,
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            if (frame == null) {
                              return Skeletonizer(
                                enabled: true,
                                child: Image.asset("assets/foods/1_1.jpg",
                                  height: 100,
                                  fit: BoxFit.cover,),
                              );
                            } else {
                              return child;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: CupertinoColors.systemGrey,
                height: 0.3, // Height of the line
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    stall.stallName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
