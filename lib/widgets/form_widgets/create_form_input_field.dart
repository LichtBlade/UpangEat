import 'package:flutter/material.dart';

class CreateFormInputField extends StatefulWidget {
  final String title;
  final String? hint;
  final TextEditingController? controller; // Form submit value

  const CreateFormInputField({
    super.key,
    required this.title,
    this.hint,
    this.controller,
  });

  @override
  State<CreateFormInputField> createState() => _CreateFormInputFieldState();
}

class _CreateFormInputFieldState extends State<CreateFormInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(14.0)),
            labelText: widget.title,
            hintText: widget.hint,
            hintStyle: const TextStyle(fontWeight: FontWeight.w300)),
      ),
    );
  }
}
