import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_parser/model/parsed_data.dart';
import 'package:olx_parser/repository/olx_repository.dart';
import 'package:olx_parser/repository/parser_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(ParserApp());
}

class ParserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  final OlxRepository _olxRepository = OlxRepository();
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
        cellBuilder: (BuildContext context, GridColumn column, int rowindex) {
          if (column.mappingName != "image") {
            return Text("Ақпарат жоқ");
          }

          return CachedNetworkImage(
            imageUrl:
                "https://frankfurt.apollo.olxcdn.com/v1/files/qvbw0gicn2be1-KZ/image;s=644x461",
          );
        },
        columns: [
          GridWidgetColumn(
            mappingName: "image",
            headerText: "Суреті",
            padding: const EdgeInsets.all(10.0),
          ),
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
          GridTextColumn(
            mappingName: 'offerUrl',
            headerText: 'Сілтеме',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.get_app),
        onPressed: () => _olxRepository.getOfferList(
          url:
              "https://www.olx.kz/kk/elektronika/kompyutery-i-komplektuyuschie/",
        ),
      ),
    );
  }
}
