import 'package:flutter/material.dart';
import 'package:olx_parser/repository/interface/license_repository.dart';
import 'package:olx_parser/ui/components/base_progress_bar.dart';

class ActivationKeyForm extends StatelessWidget {

  final LicenseRepository licenseRepository;

  String _passedLicenseKey = "";

  final Function(String licenseKey) onActivate;

  ActivationKeyForm({
    required this.licenseRepository,
    required this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: licenseRepository.getDeviceId(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Text("Қателік: " + snapshot.error.toString());
        }

        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  onChanged: (value) => _passedLicenseKey = value,
                  decoration: InputDecoration(
                    hintText: "Ключті енгізіңіз",
                  ),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Colors.greenAccent,
                  child: const Text("Активация"),
                  onPressed: () => onActivate(_passedLicenseKey),
                ),
                const SizedBox(height: 30),
                Text(
                  "ID: " + snapshot.data!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        return BaseProgressBar();
      },
    );
  }
}
