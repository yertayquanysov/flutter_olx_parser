import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_parser/model/parsed_data.dart';
import 'package:olx_parser/repository/olx_repository.dart';
import 'package:olx_parser/ui/components/parsed_data_table.dart';

import 'model/data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ParsedDataSource _parsedDataSource = ParsedDataSource();
  final OlxRepository _olxRepository = OlxRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLX парсер"),
      ),
      body: ParsedDataTable(
        parsedDataSource: _parsedDataSource,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.get_app),
        onPressed: () {
          _olxRepository
              .getAdsList(
                  url:
                      "https://www.olx.kz/kk/elektronika/kompyutery-i-komplektuyuschie/")
              .listen((event) {
            _parsedDataSource.adsList.add(event);
            _parsedDataSource.notifyListeners();
          });
        },
      ),
    );
  }
}
