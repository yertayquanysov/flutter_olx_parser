import 'package:flutter/material.dart';
import 'package:olx_parser/ui/components/admin_whatsapp.dart';

class ContactScreen extends StatelessWidget {

  static String routeName = "contacts_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Админге жазу"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Программа бойынга кез-келген мәселе бойынша админге жаза аласыз",
              style: TextStyle(fontSize: 18),
            ),
          ),
          AdminContact(),
        ],
      ),
    );
  }
}
