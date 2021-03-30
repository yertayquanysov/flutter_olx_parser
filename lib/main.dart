import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olx_parser/model/parsed_data.dart';
import 'package:olx_parser/repository/excel_repository.dart';
import 'package:olx_parser/repository/olx_repository.dart';
import 'package:olx_parser/ui/components/parse_button.dart';
import 'package:olx_parser/ui/components/url_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xFF0fb9b1)),
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
  final OlxRepository _olxRepository = OlxRepository();

  final ExcelRepository _excelRepository = ExcelRepository();

  String _parseDataUrl =
      "https://www.olx.kz/kk/elektronika/kompyutery-i-komplektuyuschie/";

  bool _isParseStarted = false;

  final List<ParsedData> _parsedDataList = [];

  StreamSubscription? _streamSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        toolbarHeight: 50,
        title: Text(
          "OLX парсер",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          UrlField(onChanged: (v) => _parseDataUrl = v),
          Visibility(
            visible: _isParseStarted,
            child: LinearProgressIndicator(),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            child: Text("Export"),
            onPressed: () => _excelRepository.exportData(),
          ),
          Visibility(
            visible: !_isParseStarted,
            child: ParseButton(
              value: 'Номерлерді жинау',
              onTap: () => startParseData(),
            ),
          ),
          Visibility(
            visible: _isParseStarted,
            child: ParseButton(value: 'Тоқтату', onTap: () => stopJob()),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(_parsedDataList.length.toString()),
        ],
      ),
    );
  }

  void listenNewAds(data) {
    setState(() {
      _parsedDataList.add(data);
    });
  }

  void startParseData() async {
    if (!_isParseStarted) {
      setState(() => _isParseStarted = true);
      _streamSubscription = _olxRepository
          .getAdsList(url: _parseDataUrl, onFinish: stopJob)
          .listen(listenNewAds);
    }
  }

  void stopJob() {
    setState(() => _isParseStarted = false);
    _streamSubscription?.cancel();
  }
}
