import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExcelRepository {
  Future exportData() async {
    var excel = Excel.createExcel();

    excel.insertRow("Имя", 0);
    excel.insertRow("Номер телефона", 1);
    excel.insertRow("Город", 2);
    excel.insertRow("Цена", 3);
    excel.insertRow("Категория", 4);
    excel.insertRow("Ссылка", 5);
    excel.insertRow("Продавец", 6);
    excel.insertRow("Дата", 7);

    final encodedData = await excel.encode();

    save(encodedData);
  }

  Future<bool> save(data) async {

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    final result = File(tempPath + "/excel.xlsx")
      ..createSync(recursive: true)
      ..writeAsBytes(data);

    print(result);

    return true;
  }
}
