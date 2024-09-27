import 'package:flutter/material.dart';
import 'package:upang_eat/repositories/category_repository_impl.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Upang Eats"),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    CategoryRepositoryImpl().fetchFoodByCategory();
                  },
                  icon: const Icon(Icons.notifications_none)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fastfood_outlined)),
            ],
          ),
        )
      ],
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }
}
