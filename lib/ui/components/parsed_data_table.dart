import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_parser/model/data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ParsedDataTable extends StatelessWidget {
  final ParsedDataSource parsedDataSource;

  ParsedDataTable({
    @required this.parsedDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: parsedDataSource,
      rowHeight: 100,
      cellBuilder: (BuildContext context, GridColumn column, int rowindex) {

        if (column.mappingName != "image") {
          return Text("Ақпарат жоқ");
        }

        return CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: parsedDataSource.adsList[rowindex].imageUrl,
        );

      },
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
    );
  }
}