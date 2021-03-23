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
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ParsedDataSource _parsedDataSource = ParsedDataSource();
  final OlxRepository _olxRepository = OlxRepository();

  String _parseDataUrl =
      "https://www.olx.kz/kk/elektronika/kompyutery-i-komplektuyuschie/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLX парсер"),
      ),
      body: Column(
        children: [
          TextField(onChanged: (v) => _parseDataUrl),
          MaterialButton(
            child: Text("Parse"),
            onPressed: startParseData,
          ),
          Expanded(
            child: ParsedDataTable(
              parsedDataSource: _parsedDataSource,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          child: const Icon(Icons.get_app),
          onPressed: () => startParseData(),
        ),
      ),
    );
  }

  void listenNewAds(event) {
    if (event != null) {
      _parsedDataSource.adsList.add(event);
      _parsedDataSource.notifyListeners();
    }
  }

  void startParseData() async {
    print("Parsing data...");
    _olxRepository.getAdsList(url: _parseDataUrl).listen(listenNewAds);
  }
}
