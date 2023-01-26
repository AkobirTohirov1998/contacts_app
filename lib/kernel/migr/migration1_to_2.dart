import 'package:gwslib/log/logger.dart';
import 'package:sqflite/sqflite.dart';

void migration1_to_2(Batch batch) {
  Log.debug("########## MD User Migrate 1 to 2 ##########");

  batch.execute("""
create table md_users(
  user_id           int not null,
  name              text not null,
  phone_number      text not null,
  photo_sha         text,
  constraint md_users_pk primary key (user_id),
);
  """);
}
