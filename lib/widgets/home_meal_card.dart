import 'package:flutter/material.dart';

class HomeMealCard extends StatefulWidget {
  final String food;
  const HomeMealCard({super.key, required this.food});

  @override
  State<HomeMealCard> createState() => _HomeMealCardState();
}

class _HomeMealCardState extends State<HomeMealCard> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14.0), bottomLeft: Radius.circular(14.0)),
              child: Image.asset(
                widget.food,
                height: 95,
                width: 95,
                fit: BoxFit.cover,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sting",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                      "Masasampal ka sa gising. Its liver lover boy")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
