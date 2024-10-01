import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: SizedBox(
        height: 200,
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const _Header(),
              Expanded(
                child: Container(
                  color: Colors.lightGreen,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [Text("data")],
                  ),
                ),
              )
            ],
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

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "Category",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          )
        ],
      ),
    );
  }
}
