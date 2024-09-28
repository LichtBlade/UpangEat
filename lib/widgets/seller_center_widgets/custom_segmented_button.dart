import 'package:flutter/material.dart';

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({super.key});

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  Set<String> _selected = {'Pending'};
  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selected = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'Pending',
          label: Text(
            'Pending',
            style: TextStyle(fontSize: 12),
          ),
        ),
        ButtonSegment<String>(
          value: 'Accepted',
          label: Text(
            'Accepted',
            style: TextStyle(fontSize: 12),
          ),
        ),
        ButtonSegment<String>(
          value: 'Ready',
          label: Text(
            'Ready',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
      selected: _selected,
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          _selected = newSelection;
        });
      },
    );
  }
}
