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
    return ElevatedButton(
      child: Text(value),
      onPressed: onTap,
    );
  }
}
