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
      color: Color(0xFF0fb9b1),
      textColor: Colors.white,
      onPressed: onTap,
      shape: SuperellipseShape(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
