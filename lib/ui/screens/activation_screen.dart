import 'package:flutter/material.dart';

class ActivationScreen extends StatelessWidget {
  static String routeName = "activation_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Активация жасау"),
      ),
      body: Column(
        children: [
          TextField(),
          MaterialButton(
            child: Text("Активация"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
