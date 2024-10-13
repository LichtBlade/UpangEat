// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:upang_eat/pages/seller_center/completed_canceled.dart';
import 'package:upang_eat/user_data.dart';

import '../../Pages/wallet_pages/wallet.dart';

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
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
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
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.cancel_outlined),
                      title: const Text('Cancelled'),
                      onTap: (){
                        final filteredOrders = globalOrders.where((order) =>
                        order.orderStatus == 'cancelled').toList();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedCanceled(orders: filteredOrders,isCompleted: false,)));
                      },
                    )
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.check_circle_outline_outlined),
                      title: const Text('Completed'),
                      onTap: (){
                        final filteredOrders = globalOrders.where((order) =>
                        order.orderStatus == 'completed').toList();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedCanceled(orders: filteredOrders,isCompleted: true,)));
                      },
                    )
                  ),
                ])
      ],
    );
  }
}
