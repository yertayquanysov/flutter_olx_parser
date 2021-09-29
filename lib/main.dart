import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olx_parser/ui/screens/activation_screen.dart';
import 'package:olx_parser/ui/screens/contact.dart';
import 'package:olx_parser/ui/screens/parser_screen.dart';
import 'package:olx_parser/ui/screens/warning_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParserScreen(),
      routes: {
        "contact": (_) => ContactScreen(),
        "warning_info": (_) => WarningScreen(),
        ActivationScreen.routeName: (_) => ActivationScreen(),
        ParserScreen.routeName: (_) => ParserScreen(),
      },
    );
  }
}
