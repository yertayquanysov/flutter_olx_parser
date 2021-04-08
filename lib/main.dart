import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olx_parser/repository/storage_repository.dart';
import 'package:olx_parser/ui/components/base_progress_bar.dart';
import 'package:olx_parser/ui/screens/activation_screen.dart';
import 'package:olx_parser/ui/screens/contact.dart';
import 'package:olx_parser/ui/screens/parser_screen.dart';
import 'package:olx_parser/ui/screens/warning_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  
  final StorageRepositoryImpl _storageRepository = StorageRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xFF0fb9b1)),
      home: FutureBuilder<String>(
        future: _storageRepository.getActivationKey(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
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
