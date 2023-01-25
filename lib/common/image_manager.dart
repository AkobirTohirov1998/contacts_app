import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//Image Manager Util class manage all images directory
class ImageManager {
  ///getImageDirection function  manage all image directory
  ///@return Directory image directory
  static Future<Directory> getImageDirection() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(
      dbFolder.path,
    ));
    var dir = await new Directory('${file.path}/photos').create(recursive: true);
    if ((await dir.exists())) {
      return dir;
    } else {
      return dir.create();
    }
  }
}
