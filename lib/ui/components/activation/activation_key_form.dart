import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class ActivationKeyForm extends StatelessWidget {
  final Function(String licenseKey) onActivate;

  String _passedLicenseKey = "";

  ActivationKeyForm({
    required this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TextBox(
            minLines: 5,
            maxLines: 5,
            placeholder: "Ключті енгізіңіз",
            onChanged: (value) => _passedLicenseKey = value,
          ),
          const SizedBox(height: 10),
          FilledButton(
            child: const Text("Активация"),
            onPressed: () => onActivate(_passedLicenseKey),
          ),
        ],
      ),
    );
  }
}
