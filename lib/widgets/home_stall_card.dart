import 'package:flutter/material.dart';
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
      child: Card(
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: Column(children: [
            Image.asset(widget.stall.imageUrl!,
                height: 100,
                width: 130,
                fit: BoxFit.cover, errorBuilder:
                    (context, error, stackTrace) {
                  return const Text('Error loading image');
                }),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: 110,
              child:
              Center(child: Text(widget.stall.stallName, maxLines: 2, overflow: TextOverflow.ellipsis,)),
            ),
          ]),
        ),
      ),
    );
  }
}
