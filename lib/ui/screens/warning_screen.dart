import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_parser/ui/components/admin_whatsapp.dart';

class WarningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ескерту"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              "Бұл ақылы программа. Заңсыз жолмен алып, кейін компьютеріңізде мәселе туындаса, бұған өзіңіз кінәлсіз. Админ email: ertai.soft@gmail.com",
              style: const TextStyle(fontSize: 18),
            ),
            AdminContact(),
          ],
        ),
      ),
    );
  }
}
