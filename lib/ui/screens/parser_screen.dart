import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_parser/model/parsed_data.dart';
import 'package:olx_parser/repository/excel_repository.dart';
import 'package:olx_parser/repository/lisence_repository.dart';
import 'package:olx_parser/repository/olx_repository.dart';
import 'package:olx_parser/ui/components/appbar.dart';
import 'package:olx_parser/ui/components/parse_button.dart';
import 'package:olx_parser/ui/components/url_field.dart';

class ParserScreen extends StatefulWidget {
  static String routeName = "parser_screen";

  ParserScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ParserScreen> {
  final OlxRepository _olxRepository = OlxRepository();
  final ExcelRepository _excelRepository = ExcelRepository();
  final LicenceRepository _licenceRepository = LicenseRepositoryImpl();

  late String _parseDataUrl;

  bool _isParseStarted = false;
  bool _isParsingCompleted = false;

  final List<ParsedData> _parsedDataList = [];

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    _licenceRepository.getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ParserAppBar(),
      body: Column(
        children: [
          UrlField(onChanged: (v) => _parseDataUrl = v),
          Visibility(
            visible: _isParseStarted,
            child: LinearProgressIndicator(),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: _isParsingCompleted && _parsedDataList.length > 0,
            child: MaterialButton(
              child: const Text("Сохранит в формате  Excel"),
              onPressed: () async {
                await _excelRepository.exportData(_parsedDataList);
                setState(() {});
              },
            ),
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
          const SizedBox(height: 10),
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
    setState(() {
      _isParseStarted = false;
      _isParsingCompleted = true;
    });

    _streamSubscription?.cancel();
  }
}
