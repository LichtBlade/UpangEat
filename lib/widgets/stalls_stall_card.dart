import 'package:flutter/cupertino.dart';
import 'package:upang_eat/pages/stall_information.dart';
import 'package:upang_eat/models/stall_model.dart';

class StallsStallCard extends StatelessWidget {
  final Stall stall;

  const StallsStallCard({super.key, required this.stall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => StallInformation(stall: stall)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFEF7FF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Row(
                    children: [
                      Image.asset(
                        stall.imageUrl!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Image.asset(
                          stall.imageBannerUrl!,
                          height: 100,
                          fit: BoxFit.cover,
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
