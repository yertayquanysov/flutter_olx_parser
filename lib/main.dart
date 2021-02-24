import 'package:flutter/material.dart';
import 'package:olx_parser/model/parsed_data.dart';
import 'package:olx_parser/parser_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final ParserRepository _parserRepository = ParserRepository();

  ParsedDataSource _parsedDataSource;

  @override
  void initState() {
    super.initState();

    _parsedDataSource = ParsedDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLX"),
      ),
      body: SfDataGrid(
        source: _parsedDataSource,
        columns: [
          GridTextColumn(
            mappingName: 'name',
            headerText: 'Аты',
          ),
          GridTextColumn(
            mappingName: 'price',
            headerText: 'Бағасы',
          ),
          GridTextColumn(
            mappingName: 'phoneNumber',
            headerText: 'Телефон номер',
          ),
          GridTextColumn(
            mappingName: 'sellerName',
            headerText: 'Сатушы',
          ),
        ],
      ),
    );
  }
}
