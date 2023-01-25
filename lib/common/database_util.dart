import 'package:gwslib/common/util.dart';
import 'package:sqflite/sqflite.dart';

extension MyDatabase on Database {
  Future<List<String>> getColumns(String tableName) {
    return rawQuery("PRAGMA table_info($tableName)")
        .then((value) => value.map((e) => nvlString(e["name"])).toList());
  }

  Future<void> txn(Future<void> run()) async {
    await this.execute("BEGIN TRANSACTION");
    try {
      await run.call();
    } catch (e, st) {
      print("Error($e)\n$st");
      rethrow;
    } finally {
      await this.execute("ROLLBACK");
    }
  }

  Future<void> startCheckForeignKey() => this.execute("PRAGMA foreign_keys = ON");

  Future<void> stopCheckForeignKey() => this.execute("PRAGMA foreign_keys = OFF");

}
