import 'package:flutter_test/flutter_test.dart';
import 'package:olx_parser/model/license_key.dart';

void main() async {
  test("return device id", () async {

    final deviceId = "OIheiuwfefwefwefawefawef";

    final Map<String, dynamic> jsonData = {"deviceId": deviceId};
    final keyObject = LicenseKey.fromJson(jsonData);

    expect(deviceId, keyObject.deviceId);
  });

  test("return empty", () async {
    final Map<String, dynamic> jsonData = {};

    final keyObject = LicenseKey.fromJson(jsonData);

    expect("", keyObject.deviceId);
  });
}
