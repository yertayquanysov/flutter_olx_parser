import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olx_parser/repository/license_repository.dart';
import 'package:olx_parser/repository/local_database_repository.dart';
import 'package:olx_parser/ui/components/base_progress_bar.dart';
import 'package:olx_parser/ui/components/error_message.dart';
import 'package:olx_parser/ui/screens/activation_screen.dart';
import 'package:olx_parser/ui/screens/contact.dart';
import 'package:olx_parser/ui/screens/parser_screen.dart';
import 'package:olx_parser/ui/screens/warning_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  final _licenseRepository = LocalDatabaseRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0fb9b1),
      ),
      home: FutureBuilder<String>(
        future: _licenseRepository.getActivationKey(),
        builder: (_, snapshot) {

          if (snapshot.hasError) {
            return ErrorMessage();
          }

          if (snapshot.hasData) {

            final String activationKey = snapshot.data!;

            if (activationKey.isEmpty) {
              return ActivationScreen();
            } else {
              return ParserScreen();
            }
          }

          return BaseProgressBar();
        },
      ),
      routes: {
        "contact": (_) => ContactScreen(),
        ActivationScreen.routeName: (_) => ActivationScreen(),
        "warning_info": (_) => WarningScreen(),
        ParserScreen.routeName: (_) => ParserScreen(),
      },
    );
  }
}
