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
          hintText: "Сілтемені енгізіңіз",
          contentPadding: const EdgeInsets.only(
            right: 18,
            left: 18,
            top: 5,
            bottom: 5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 3),
          ),
        ),
      ),
    );
  }
}
