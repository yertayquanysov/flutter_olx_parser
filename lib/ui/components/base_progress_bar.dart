import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class BaseProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ProgressRing(),
    );
  }
}
