import 'dart:io';

import 'package:excel/excel.dart';
import 'package:olx_parser/model/parsed_data.dart';
import 'package:path_provider/path_provider.dart';

class ExcelRepository {
  Future<bool> exportData(List<ParsedData> parsedData) async {
    final excel = Excel.createExcel();

    var defaultSheet = excel["parser"];

    List<String> dataList = [
      "Имя",
      "Номер телефона",
      "Город",
      "Цена",
      "Категория",
      "Ссылка",
      "Продавец",
      "Дата"
    ];

    defaultSheet.insertRowIterables(dataList, 0);

    parsedData.asMap().forEach((key, value) {
      defaultSheet.insertRowIterables([
        value.name,
        value.phoneNumber,
        value.city,
        value.price,
        value.categoryName,
        value.offerUrl,
        value.sellerName,
        value.date,
      ], key + 1);
    });

    final encodedData = await excel.encode();

    await save(encodedData);

    return true;
  }

  Future<bool> save(data) async {
    try {
      final Directory tempDir = await getApplicationDocumentsDirectory();
      final String tempPath = tempDir.path;

      File(tempPath + "/app.xlsx")
        ..createSync()
        ..writeAsBytesSync(data);

      return true;
    } catch (e) {
      return false;
    }
  }
}
