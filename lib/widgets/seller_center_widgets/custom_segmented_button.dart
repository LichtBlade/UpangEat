import 'package:flutter/cupertino.dart';

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({super.key});

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    String? _currentText;

    return Column(
      children: [
        CupertinoSegmentedControl(
          selectedColor: const Color.fromARGB(255, 222, 15, 57),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onValueChanged: (String value) {
            setState(() {
             _currentText = value;
            });
          },
          children: const <String, Widget>{

          },
        ),
      ],
    );
  }
}
