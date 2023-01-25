// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class MdUsers {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "md_users";
	// ignore: non_constant_identifier_names
	static const String C_USER_ID = "user_id";
	// ignore: non_constant_identifier_names
	static const String C_NAME = "name";
	// ignore: non_constant_identifier_names
	static const String C_GENDER = "gender";
	// ignore: non_constant_identifier_names
	static const String C_PHOTO_SHA = "photo_sha";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table md_users(
	  user_id           int not null,
	  name              text not null,
	  gender            text,
	  photo_sha         text,
	  constraint md_users_pk primary key (user_id),
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int userId, String name) {
		ArgumentError.checkNotNull(userId, C_USER_ID);
		ArgumentError.checkNotNull(name, C_NAME);
	}

	static void checkPrimaryKeys(int userId) {
		ArgumentError.checkNotNull(userId, C_USER_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int userId;
	final String name;
	final String gender;
	final String photoSha;

	MdUsers({@required this.userId, @required this.name, this.gender, this.photoSha}) {
		checkPrimaryKeys(userId);
	}

	factory MdUsers.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_USER_ID]);
		return MdUsers(
			userId: data[C_USER_ID],
			name: data[C_NAME],
			gender: data[C_GENDER],
			photoSha: data[C_PHOTO_SHA],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_USER_ID: this.userId,
			C_NAME: this.name,
			C_GENDER: this.gender,
			C_PHOTO_SHA: this.photoSha,
		};
	}

	@override
	String toString() {
		 return "MdUsers($C_USER_ID:$userId, $C_NAME:$name, $C_GENDER:$gender, $C_PHOTO_SHA:$photoSha)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_MdUsers {

	// init
	static MdUsers init({@required int userId, @required String name, String gender, String photoSha}) {
		MdUsers.checkPrimaryKeys(userId);
		return new MdUsers(userId: userId, name: name, gender: gender, photoSha: photoSha);
	}

	// load all rows in database
	static Future<List<MdUsers>> loadAll(Database db) {
		return db.query(MdUsers.TABLE_NAME)
			.then((it) => it.map((d) => MdUsers.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<MdUsers> take(Database db, int userId) async {
		MdUsers.checkPrimaryKeys(userId);
		final result = await db.query(MdUsers.TABLE_NAME, where: "${MdUsers.C_USER_ID} = ?", whereArgs: [userId]);
		return result.isEmpty ? null : MdUsers.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<MdUsers> load(Database db, int userId) async {
		MdUsers.checkPrimaryKeys(userId);
		final result = await take(db, userId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int userId) {
		MdUsers.checkPrimaryKeys(userId);
		return take(db, userId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int userId, void onResult(MdUsers row)) async {
		MdUsers.checkPrimaryKeys(userId);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, userId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(dynamic db, MdUsers row, {bool removeNull = false}) {
		MdUsers.checkPrimaryKeys(row.userId);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.update(MdUsers.TABLE_NAME, data, where: "${MdUsers.C_USER_ID} = ?", whereArgs: [row.userId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.update(MdUsers.TABLE_NAME, data, where: "${MdUsers.C_USER_ID} = ?", whereArgs: [row.userId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// update by one
	static Future<int> updateOne(dynamic db, {@required int userId, String name, String gender, String photoSha, bool removeNull = false}) {
		MdUsers.checkPrimaryKeys(userId);
		return updateRow(db, toRowFromList(values: [userId, name, gender, photoSha]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(dynamic db, MdUsers row, {bool removeNull = false}) {
		MdUsers.checkPrimaryKeys(row.userId);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		if (db is Batch) {
			db.insert(MdUsers.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(MdUsers.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// save one
	static Future<int> saveOne(dynamic db, {@required int userId, @required String name, String gender, String photoSha, bool removeNull = false}) {
		MdUsers.checkPrimaryKeys(userId);
		return saveRow(db, toRowFromList(values: [userId, name, gender, photoSha]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(dynamic db) {
		if (db is Batch) {
			db.delete(MdUsers.TABLE_NAME);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(MdUsers.TABLE_NAME);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// delete row by primary key
	static Future<int> deleteOne(dynamic db, int userId) {
		MdUsers.checkPrimaryKeys(userId);
		if (db is Batch) {
			 db.delete(MdUsers.TABLE_NAME, where: "${MdUsers.C_USER_ID} = ?", whereArgs: [userId]);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.delete(MdUsers.TABLE_NAME, where: "${MdUsers.C_USER_ID} = ?", whereArgs: [userId]);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(dynamic db, MdUsers row) {
		MdUsers.checkRequired(row.userId, row.name);
		if (db is Batch) {
			db.insert(MdUsers.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(MdUsers.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOneTry(dynamic db, {@required int userId, @required String name, String gender, String photoSha}) {
		MdUsers.checkRequired(userId, name);
		return insertRowTry(db, toRowFromList(values: [userId, name, gender, photoSha]));
	}

	// insert row if exists fail
	static Future<int> insertRow(dynamic db, MdUsers row) {
		MdUsers.checkRequired(row.userId, row.name);
		if (db is Batch) {
			db.insert(MdUsers.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
			return Future.value(-1);
		}
		else if (db is Database) {
			return db.insert(MdUsers.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
		}
		else{
			throw Exception("db object must be instance of Database or Batch");
		}
	}

	static Future<int> insertOne(dynamic db, {@required int userId, @required String name, String gender, String photoSha}) {
		MdUsers.checkRequired(userId, name);
		return insertRow(db, toRowFromList(values: [userId, name, gender, photoSha]));
	}

	// to map
	static Map<String, dynamic> toMap({MdUsers row, String f1, String f2, String f3, String f4, int userId, String name, String gender, String photoSha}) {
		userId = nvl(row?.userId, userId);
		name = nvl(row?.name, name);
		gender = nvl(row?.gender, gender);
		photoSha = nvl(row?.photoSha, photoSha);
		MdUsers.checkRequired(userId, name);
		return {nvlString(f1, MdUsers.C_USER_ID): userId, nvlString(f2, MdUsers.C_NAME): name, nvlString(f3, MdUsers.C_GENDER): gender, nvlString(f4, MdUsers.C_PHOTO_SHA): photoSha};
	}

	// to list
	static List<dynamic> toList({MdUsers row, int userId, String name, String gender, String photoSha}) {
		userId = nvl(row?.userId, userId);
		name = nvl(row?.name, name);
		gender = nvl(row?.gender, gender);
		photoSha = nvl(row?.photoSha, photoSha);
		MdUsers.checkRequired(userId, name);
		return [userId, name, gender, photoSha];
	}

	// to row from map
	static MdUsers toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, int userId, String name, String gender, String photoSha}) {
		userId = nvl(data == null ? null : data[nvl(f1, MdUsers.C_USER_ID)], userId);
		name = nvl(data == null ? null : data[nvl(f2, MdUsers.C_NAME)], name);
		gender = nvl(data == null ? null : data[nvl(f3, MdUsers.C_GENDER)], gender);
		photoSha = nvl(data == null ? null : data[nvl(f4, MdUsers.C_PHOTO_SHA)], photoSha);
		MdUsers.checkPrimaryKeys(userId);
		return new MdUsers(userId: userId, name: name, gender: gender, photoSha: photoSha);
	}

	// to row from list
	static MdUsers toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4}) {
		final userId = values[keys?.indexOf(nvl(f1, MdUsers.C_USER_ID)) ?? 0];
		final name = values[keys?.indexOf(nvl(f2, MdUsers.C_NAME)) ?? 1];
		final gender = values[keys?.indexOf(nvl(f3, MdUsers.C_GENDER)) ?? 2];
		final photoSha = values[keys?.indexOf(nvl(f4, MdUsers.C_PHOTO_SHA)) ?? 3];
		MdUsers.checkPrimaryKeys(userId);
		return new MdUsers(userId: userId, name: name, gender: gender, photoSha: photoSha);
	}

	// to row from list strings
	static MdUsers toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4}) {
		dynamic userId = values[keys?.indexOf(nvl(f1, MdUsers.C_USER_ID)) ?? 0];
		dynamic name = values[keys?.indexOf(nvl(f2, MdUsers.C_NAME)) ?? 1];
		dynamic gender = values[keys?.indexOf(nvl(f3, MdUsers.C_GENDER)) ?? 2];
		dynamic photoSha = values[keys?.indexOf(nvl(f4, MdUsers.C_PHOTO_SHA)) ?? 3];
		userId = userId is String && userId.isNotEmpty ? num.parse(userId) : null;
		MdUsers.checkPrimaryKeys(userId);
		return new MdUsers(userId: userId, name: name, gender: gender, photoSha: photoSha);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
