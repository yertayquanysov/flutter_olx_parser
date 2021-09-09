import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olx_parser/repository/license_repository.dart';
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
  final _licenseRepository = LicenseRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      home: FutureBuilder<bool>(
        future: _licenseRepository.checkLicenseKey(),
        builder: (_, snapshot) {

          if (snapshot.hasError) {
            print(snapshot.error);
            return ErrorMessage();
          }

          if (snapshot.hasData) {

            final isSuccess = snapshot.data!;

            if (!isSuccess) {
              return ActivationScreen();
            } else {
              return ParserScreen();
            }
          }

          return BaseProgressBar();
        },
      ),
      routes: {
        ContactScreen.routeName: (_) => ContactScreen(),
        ActivationScreen.routeName: (_) => ActivationScreen(),
        WarningScreen.routeName: (_) => WarningScreen(),
        ParserScreen.routeName: (_) => ParserScreen(),
      },
    );
  }
}
