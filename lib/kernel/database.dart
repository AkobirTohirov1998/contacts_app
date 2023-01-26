import 'dart:io';

import 'package:first_app/kernel/contact/table/users.dart';
import 'package:first_app/kernel/migr/migration1_to_2.dart';
import 'package:gwslib/gwslib.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

export 'contact/md_api.dart';
export 'contact/table/users.dart';

class AppExampleDatabase extends MyDatabase {
  static const SCHEMA = "example_app";
  static const DATABASE = "${SCHEMA}_v1.db";
  static const VERSION = 2;

  static AppExampleDatabase getInstance() => MyDatabase.instance(DATABASE);

  static bool isDatabaseOpen() => MyDatabase.isDatabaseOpen(DATABASE);

  static void onConfigure(Batch batch) {}

  static void onCreate(Batch batch) {
    Log.debug("########## Execute MD Tables ##########");
    batch.execute(MdUsers.TABLE);
  }

  static Future<AppExampleDatabase> newInstance() async {
    String path = await getDatabasesPath().then((path) => join(path, DATABASE));

    final database = await connectDatabase(DATABASE, path, onCreate: onCreate);
    if (Platform.isIOS) {
      path = SCHEMA;
    }
    final db = AppExampleDatabase(database);
    await db.init(calcSha256(path));
    return db;
  }

  AppExampleDatabase(Database db) : super(DATABASE, db);

  @override
  Future<void> init(String databaseKey) async {
    return super.init(databaseKey).then((value) => onCheckVersion(databaseKey, SCHEMA, VERSION));
  }

  @override
  void onDowngrade(String schema, Batch batch) {
    if (schema == SCHEMA) {
      Log.debug("########## Execute drop MD Tables ##########");
      batch.rawQuery("drop table ${MdUsers.TABLE_NAME}");

      onCreate(batch);
    } else {
      super.onDowngrade(schema, batch);
    }
  }

  @override
  void onUpgrade(String schema, Batch batch, int oldVersion, int newVersion) {
    if (schema == SCHEMA) {
      if (oldVersion == 1 && newVersion == 2) {
        migration1_to_2(batch);
      } else {
        super.onUpgrade(schema, batch, oldVersion, newVersion);
      }
    }
  }
}
