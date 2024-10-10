import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upang_eat/Pages/stall_information.dart';
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
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => StallInformation(stall: widget.stall),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray, // Set background color
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Column(
              children: [
                Image.asset(
                  widget.stall.imageUrl!,
                  height: 100,
                  width: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Error loading image');
                  },
                ),
                SizedBox(
                  width: 110,
                  child: Center(
                    child: Text(
                      widget.stall.stallName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
