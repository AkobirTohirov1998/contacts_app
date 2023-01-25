import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:first_app/common/photo_resolution.dart';
import 'package:image/image.dart' as imgLib;
import 'package:path_provider/path_provider.dart';

class FileStorage {
  ///delete file with [filename] property from local storage
  static Future<int> deleteFile(String filename) {
    return getApplicationSupportDirectory().then((value) => value.listSync()).then((value) {
      final files = value.where((e) => e.path.contains(filename));
      return files.map((e) => e.deleteSync()).length;
    });
  }

  static Future<File> getNewFile(String sha, {String format = "tmp"}) {
    return getApplicationSupportDirectory().then((dir) {
      return File("${dir.path}/$sha.$format");
    });
  }

  static Future<List<String>> loadAllFiles({String format = "tmp"}) {
    return getApplicationSupportDirectory().then((dir) {
      return dir
          .listSync()
          .where((e) => e.path.endsWith(".$format"))
          .map((e) => e.path.split("/").last)
          .map((e) => e.split(".").first)
          .toList();
    });
  }

  /// generate file path with [sha] and [format]. by default [format] equals "tmp"
  ///
  ///@ return Future<File> generated file
  static Future<File> loadFilePath(String sha, {String format = "tmp"}) =>
      getApplicationSupportDirectory().then((value) => File("${value.path}/$sha.$format"));

  ///load file with [sha]. Firstly generate file path and read bytes
  ///
  /// @return Future<Uint8List>
  static Future<Uint8List> loadFile(String sha, {String format = "tmp"}) {
    return loadFilePath(sha, format: format).then((value) async {
      if (await value.exists()) {
        return value.readAsBytes();
      }
      return null;
    });
  }

  ///save bytes[original] to phone local storage. Firstly generate sha unique key from [original]
  ///
  /// @return Future<String> generated sha key
  static Future<String> saveFile(Uint8List original, {String fileSha, String format = "tmp"}) {
    final sha = fileSha ?? sha256.convert(original).toString();
    return getApplicationSupportDirectory().then((value) {
      final f = File("${value.path}/$sha.$format");
      return f.writeAsBytes(original.toList(), flush: true);
    }).then((value) => sha);
  }

  static Future<List<String>> loadAllCachePhotos() => loadAllFiles(format: "cimg");

  static Future<String> saveCachePhoto(Uint8List original, {String photoSha}) =>
      saveFile(original, fileSha: photoSha, format: "cimg");

  static Future<void> saveThumbnailCachePhoto(
    Uint8List bytes, {
    String photoSha,
    PhotoResolution resolution = PhotoResolution.LOW,
    String format = "cimg",
  }) async {
    final sha = photoSha?.isNotEmpty == true
        ? "${photoSha}_thumbnail_${resolution.width}_${resolution.height}"
        : sha256.convert(bytes).toString();

    imgLib.Image image = imgLib.decodeImage(bytes);
    int orgWidth = image?.width;
    int orgHeight = image?.height;
    int width = resolution.width;
    int height = resolution.height;

    if (orgWidth != null && orgHeight != null) {
      if (orgHeight > orgWidth) {
        width = orgHeight != 0 ? (orgWidth * (height / orgHeight)).toInt() : 0;
      } else {
        height = orgWidth != 0 ? (orgHeight * (width / orgWidth)).toInt() : 0;
      }
    }

    imgLib.Image thumbPhoto = imgLib.copyResize(image, width: width, height: height);

    imgLib.JpegEncoder encoder = imgLib.JpegEncoder();

    Uint8List thumb = encoder.encodeImage(thumbPhoto);
    return saveCachePhoto(thumb, photoSha: sha);
  }

  static Future<Uint8List> loadThumbnailCachePhoto(String sha,
      {PhotoResolution resolution = PhotoResolution.LOW}) async {
    if (resolution == PhotoResolution.HIGH) {
      return loadCachePhoto(sha);
    }

    Uint8List thumbnailPhoto =
        await loadCachePhoto("${sha}_thumbnail_${resolution.width}_${resolution.height}");
    if (thumbnailPhoto != null) return thumbnailPhoto;

    Uint8List originalPhoto = await loadCachePhoto(sha);
    if (originalPhoto != null) {
      await saveThumbnailCachePhoto(originalPhoto, photoSha: sha, resolution: resolution);
      return loadCachePhoto("${sha}_thumbnail_${resolution.width}_${resolution.height}");
    }
    return null;
  }

  static Future<File> newCachePhoto(String sha) => getNewFile(sha, format: "cimg");

  ///load photo with [sha]
  ///
  /// @return Future<Uint8List> photo bytes
  static Future<Uint8List> loadCachePhoto(String sha) => loadFile(sha, format: "cimg");

  ///save photo [original] with "JPG" format to phone local storage.
  ///
  /// @return Future<String> generated sha key
  static Future<String> savePhoto(Uint8List original) => saveFile(original, format: "jpg");

  ///load photo with [sha]
  ///
  /// @return Future<Uint8List> photo bytes
  static Future<Uint8List> loadPhoto(String sha) => loadFile(sha, format: "jpg");

  ///load photo file with [sha]
  ///
  /// @return Future<File> photo path
  static Future<File> loadPhotoFile(String sha) => loadFilePath(sha, format: "jpg");

  ///save video [original] with "mp4" format to phone local storage.
  ///
  /// @return Future<String> generated sha key
  static Future<String> saveVideo(Uint8List original) => saveFile(original, format: "mp4");

  ///load video with [sha]
  ///
  /// @return Future<Uint8List> video bytes
  static Future<Uint8List> loadVideo(String sha) => loadFile(sha, format: "mp4");

  ///load video file path
  ///
  /// @return Future<File> generated file
  static Future<File> loadVideoFile(String sha) => loadFilePath(sha, format: "mp4");
}
