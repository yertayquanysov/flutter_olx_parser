import 'package:flutter/material.dart';

class UrlField extends StatelessWidget {
  final Function(String) onChanged;

  UrlField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 18, bottom: 8),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Введите ссылку",
        ),
      ),
    );
  }
}
