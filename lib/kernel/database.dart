import 'dart:io';

import 'package:gwslib/gwslib.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import 'migr/migration3_to_4.dart';

// export 'md/md_api.dart';
// export 'md/md_core.dart';
// export 'md/md_util.dart';
// export 'md/tables/filials.dart';
// export 'md/tables/servers.dart';
// export 'md/tables/users.dart';

class AppExampleDatabase extends MyDatabase {
  static const SCHEMA = "account";
  static const DATABASE = "oc_${SCHEMA}_v1.db";
  static const VERSION = 5;

  static MyDatabase getInstance() => MyDatabase.instance(DATABASE);

  static bool isDatabaseOpen() => MyDatabase.isDatabaseOpen(DATABASE);

  static void onConfigure(Batch batch) {}

  static void onCreate(Batch batch) {
    // Log.debug("########## Execute MD Tables ##########");
    // batch.execute(MdServers.TABLE);
    // batch.execute(MdUsers.TABLE);
    // batch.execute(MdFilials.TABLE);
    // batch.execute(MdPasswordPolicy.TABLE);
    // batch.execute(MdUserFilialRoles.TABLE);
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
      // Log.debug("########## Execute drop MD Tables ##########");
      // batch.rawQuery("drop table ${MdUserFilialRoles.TABLE_NAME}");
      // batch.rawQuery("drop table ${MdPasswordPolicy.TABLE_NAME}");
      // batch.rawQuery("drop table ${MdFilials.TABLE_NAME}");
      // batch.rawQuery("drop table ${MdUsers.TABLE_NAME}");
      // batch.rawQuery("drop table ${MdServers.TABLE_NAME}");

      onCreate(batch);
    } else {
      super.onDowngrade(schema, batch);
    }
  }

  @override
  void onUpgrade(String schema, Batch batch, int oldVersion, int newVersion) {
    // if (schema == SCHEMA) {
    //   if (oldVersion == 1 && newVersion == 2) {
    //     migration1_to_2(batch);
    //   } else if (oldVersion == 2 && newVersion == 3) {
    //     migration2_to_3(batch);
    //   } else if (oldVersion == 3 && newVersion == 4) {
    //     migration3_to_4(batch);
    //   } else if (oldVersion == 4 && newVersion == 5) {
    //     migration4_to_5(batch);
    //   }
    // } else {
    //   super.onUpgrade(schema, batch, oldVersion, newVersion);
    // }
  }
}
