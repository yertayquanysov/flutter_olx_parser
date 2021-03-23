import 'package:olx_parser/model/parsed_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ParsedDataSource extends DataGridSource<ParsedData> {

  final List<ParsedData> adsList = [];

  @override
  List<ParsedData> get dataSource => adsList;

  @override
  bool shouldRecalculateColumnWidths() => false;

  String getValue(ParsedData data, String columnName) {
    try {
      return data.toDocument()[columnName].toString();
    } catch (e) {
      return "No";
    }
  }
}
