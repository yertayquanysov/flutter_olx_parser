import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_parser/model/data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ParsedDataTable extends StatelessWidget {
  final ParsedDataSource parsedDataSource;

  ParsedDataTable({
    required this.parsedDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: parsedDataSource,
      rowHeight: 100,
      columns: [
        GridTextColumn(
          mappingName: 'name',
          headerText: 'Аты',
        ),
        GridWidgetColumn(
          mappingName: "image",
          headerText: "Суреті",
          padding: const EdgeInsets.all(18.0),
        ),
        GridWidgetColumn(
          mappingName: "city",
          headerText: "Қала",
          padding: const EdgeInsets.all(18.0),
        ),
        GridWidgetColumn(
          mappingName: "date",
          headerText: "Күні",
          padding: const EdgeInsets.all(18.0),
        ),
        GridWidgetColumn(
          mappingName: "categoryName",
          headerText: "Санат",
          padding: const EdgeInsets.all(18.0),
        ),
        GridWidgetColumn(
          mappingName: "sellerName",
          headerText: "Сатушы",
          padding: const EdgeInsets.all(18.0),
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
          mappingName: 'offerUrl',
          headerText: 'Сілтеме',
        ),
      ],
    );
  }
}
