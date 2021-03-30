import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExcelRepository {
  Future exportData() async {
    final excel = Excel.createExcel();

    await excel.setDefaultSheet("parser");

    var sheetName = await excel.getDefaultSheet();

    var defaultSheet = excel[sheetName];

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

    final encodedData = await excel.encode();

    save(encodedData);
  }

  Future<bool> save(data) async {
    final Directory tempDir = await getApplicationDocumentsDirectory();
    final String tempPath = tempDir.path;

    final result = File(tempPath + "/app.xlsx")
      ..createSync()
      ..writeAsBytesSync(data);

    print(result);

    return true;
  }
}
