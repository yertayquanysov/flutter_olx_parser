import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class ParseButton extends StatelessWidget {
  final VoidCallback onTap;
  final String value;

  ParseButton({
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(value),
      padding: const EdgeInsets.all(20),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: onTap,
      shape: SuperellipseShape(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
