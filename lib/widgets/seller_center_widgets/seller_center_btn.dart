import 'package:flutter/material.dart';

class SellerCenterBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SellerCenterBtn({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 380,
        height: 48,
        decoration: const ShapeDecoration(
            color: Color.fromARGB(255, 222, 15, 57),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(12),
            ))),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const Icon(
                Icons.navigate_next_sharp,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
