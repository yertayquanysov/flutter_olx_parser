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
          TextField(
            minLines: 5,
            maxLines: 5,
            onChanged: (value) => _passedLicenseKey = value,
            decoration: InputDecoration(
              hintText: "Ключті енгізіңіз",
            ),
          ),
          MaterialButton(
            child: const Text("Активация"),
            onPressed: () => onActivate(_passedLicenseKey),
          ),
        ],
      ),
    );
  }
}
