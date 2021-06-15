import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async => launch("https://wa.me/77058958692"),
      child: const Text("WhatsApp - та жазу"),
    );
  }
}
