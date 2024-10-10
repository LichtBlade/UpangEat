// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SellerCenterAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String stallName;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const SellerCenterAppbar({
    super.key,
    required this.stallName,
  });

  @override
  State<SellerCenterAppbar> createState() => _SellerCenterAppbarState();
}

class _SellerCenterAppbarState extends State<SellerCenterAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 222, 15, 57),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.stallName,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.cancel_outlined),
                      title: Text('Canceled'),
                    )
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.check_circle_outline_outlined),
                      title: Text('Completed'),
                    )
                  ),
                ])
      ],
    );
  }
}
