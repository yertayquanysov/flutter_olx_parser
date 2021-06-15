import 'package:flutter_test/flutter_test.dart';
import 'package:olx_parser/repository/local_database_repository.dart';

void main() {
  final LocalDatabaseRepository _db = LocalDatabaseRepositoryImpl();

  test("test get empty data", () async {
    expect("", await _db.getSavedKey());
  });

  test("test save key", () async {
    final String key = "key111";
    await _db.saveKey(key);
    expect(key, await _db.getSavedKey());
  });

  tearDown(() async {
    await _db.clear();
  });
}
