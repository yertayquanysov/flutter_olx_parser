import 'package:flutter/material.dart';
import 'package:olx_parser/model/data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ParsedDataTable extends StatelessWidget {
  final ParsedDataSource parsedDataSource;
  final bool isParseStarted;

  ParsedDataTable({
    required this.parsedDataSource,
    required this.isParseStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isParseStarted,
      child: Expanded(
        child: SfDataGrid(
          source: parsedDataSource,
          columnWidthMode: ColumnWidthMode.fill,
          rowHeight: 100,
          columns: [
            GridTextColumn(
              mappingName: 'name',
              headerText: 'Аты',
            ),
            GridTextColumn(
              mappingName: "city",
              headerText: "Қала",
              padding: const EdgeInsets.all(18.0),
            ),
            GridTextColumn(
              mappingName: "date",
              headerText: "Күні",
              padding: const EdgeInsets.all(18.0),
            ),
            GridTextColumn(
              mappingName: "price",
              headerText: "Бағасы",
              padding: const EdgeInsets.all(18.0),
            ),
            GridTextColumn(
              mappingName: "sellerName",
              headerText: "Сатушы",
              padding: const EdgeInsets.all(18.0),
            ),
            GridTextColumn(
              mappingName: 'categoryName',
              headerText: 'Санат',
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
        ),
      ),
    );
  }
}
