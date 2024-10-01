import 'package:flutter/material.dart';
import 'package:upang_eat/Pages/stall_information.dart';
import 'package:upang_eat/models/stall_model.dart';

class StallsStallCard extends StatelessWidget {
  final Stall stall;

  const StallsStallCard({super.key, required this.stall});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StallInformation(stall: stall)));
        },
        child: Card(
          elevation: 6,
          color: const Color(0xFFFEF7FF),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        stall.imageUrl!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Image.asset(stall.imageBannerUrl!,
                              height: 100, fit: BoxFit.cover))
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black26,
                thickness: 0.3,
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
