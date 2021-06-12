import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class ParseButton extends StatelessWidget {
  final VoidCallback onTap;
  final String value;

  ParseButton({
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      child: Text(value),
      onPressed: onTap,
    );
  }
}
