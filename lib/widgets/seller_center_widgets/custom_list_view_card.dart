import 'package:flutter/material.dart';

class CustomListViewCard extends StatefulWidget {
  final int itemCount;
  final Widget item;
  final double? maxHeight;
  final double? minHeight;

  const CustomListViewCard(
      {super.key,
      required this.itemCount,
      required this.item,
      this.maxHeight,
      this.minHeight});

  @override
  State<CustomListViewCard> createState() => _CustomListViewCardState();
}

class _CustomListViewCardState extends State<CustomListViewCard> {
  int itemCount = 0;
  double maxHeight = 0;
  double minHeight = 0;
  late Widget item;

  @override
  void initState() {
    super.initState();

    itemCount = widget.itemCount;
    item = widget.item;
    maxHeight = widget.maxHeight == null ? 500: widget.maxHeight!;
    minHeight = widget.minHeight == null ? 250 : widget.minHeight!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            //Size
            maxHeight: maxHeight,
            minHeight: minHeight,
          ),
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return item;
            },
          ),
        ),
      ),
    );
  }
}
