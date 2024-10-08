import 'package:flutter/material.dart';

class SellerCenterBtn extends StatefulWidget {
  final String label;

  const SellerCenterBtn({super.key, required this.label});

  @override
  State<SellerCenterBtn> createState() => _SellerCenterBtnState();
}

class _SellerCenterBtnState extends State<SellerCenterBtn> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 222, 15, 57),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          // side: BorderSide(color: Colors.transparent, width: 0),
          side: BorderSide.none,
        ),
        // shadowColor: Colors.black,
        // elevation: 4.0,
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
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
    );
  }
}
