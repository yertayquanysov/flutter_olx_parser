import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Қателік. Жауып, қайта ашып көріңіз.",
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
