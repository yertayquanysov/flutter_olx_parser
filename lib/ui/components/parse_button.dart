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
      textColor: Colors.white,
      color: Colors.green,
      onPressed: onTap,
      shape: SuperellipseShape(
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
        bottom: 15,
      ),
    );
  }
}
