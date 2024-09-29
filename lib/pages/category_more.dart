import 'package:flutter/material.dart';
import 'package:upang_eat/Widgets/custom_drawer.dart';

class CategoryMore extends StatefulWidget {
  const CategoryMore({super.key});

  @override
  State<CategoryMore> createState() => _CategoryMoreState();
}

class _CategoryMoreState extends State<CategoryMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      drawer: const CustomDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Category"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
