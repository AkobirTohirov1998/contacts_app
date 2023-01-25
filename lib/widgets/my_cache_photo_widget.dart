import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:first_app/common/file_storage.dart';
import 'package:first_app/common/my_result.dart';
import 'package:first_app/common/photo_resolution.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class MyCachePhotoWidget extends MoldStatefulWidget {
  String url;
  String photoSha;
  double height = double.infinity;
  double width = double.infinity;
  BoxFit fit;
  Function onTap;
  Function(Uint8List) onImageClick;
  EdgeInsets padding;
  Widget Function(BuildContext) placeHolderWidgetBuilder;
  Widget Function(BuildContext) errorWidgetBuilder;
  PhotoResolution photoResolution;
  bool allowDownloadFromNetwork;

  MyCachePhotoWidget(
    this.url, {
    this.photoSha,
    this.width,
    this.height,
    this.fit,
    this.onTap,
    this.onImageClick,
    this.padding,
    this.placeHolderWidgetBuilder,
    this.errorWidgetBuilder,
    this.photoResolution = PhotoResolution.LOW,
    this.allowDownloadFromNetwork = false,
  });

  final MyCachePhotoViewModel _viewModel = MyCachePhotoViewModel();

  @override
  void onCreate() {
    super.onCreate();
    _viewModel.onCreate();
  }

  @override
  void onDestroy() {
    _viewModel.onDestroy();
    super.onDestroy();
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    _viewModel.downloadImage(photoSha, url, photoResolution,
        allowDownloadFromNetwork: allowDownloadFromNetwork);
    Widget body = StreamBuilder<MyResult<Uint8List>>(
        stream: _viewModel.photo,
        builder: (_, snapshot) {
          if (snapshot?.hasData == true) {
            if (snapshot.data is MySuccessResult) {
              return Image.memory(
                snapshot.data.data,
                height: height,
                width: width,
                fit: fit,
              );
            } else if (snapshot.data is MyErrorResult) {
              return errorWidgetBuilder?.call(context) ??
                  Container(
                    height: height,
                    width: width,
                    child: Center(
                      child: MyIcon.icon(Icons.broken_image, size: 24, color: Colors.grey),
                    ),
                  );
            } else {
              return Container();
            }
          } else {
            return placeHolderWidgetBuilder?.call(context) ??
                Container(
                  height: height,
                  width: width,
                  child: Center(child: CircularProgressIndicator()),
                );
          }
        });

    if (padding != null) {
      body = Padding(padding: padding, child: body);
    }
    if (this.onTap != null || this.onImageClick != null) {
      body = GestureDetector(
          child: body,
          onTap: () {
            this.onTap?.call();
            if (photoResolution != PhotoResolution.HIGH) {
              _viewModel.loadOriginalImage(photoSha).then((value) {
                this.onImageClick?.call(value);
              });
            } else {
              this.onImageClick?.call(_viewModel.getPhotoBytes);
            }
          });
    }
    return body;
  }
}

class MyCachePhotoViewModel extends ViewModel {
  LazyStream<MyResult<Uint8List>> _photo = LazyStream();
  LazyStream<bool> _progress = LazyStream(() => false);
  String currentImageUrl;

  Stream<MyResult<Uint8List>> get photo => _photo.stream;

  Stream<bool> get progress => _progress.stream;

  Uint8List get getPhotoBytes => _photo?.value?.data;

  Future<Uint8List> loadOriginalImage(String sha) {
    return FileStorage.loadCachePhoto(sha);
  }

  void downloadImage(String sha, String url, PhotoResolution resolution,
      {bool allowDownloadFromNetwork = false}) async {
    if (currentImageUrl != url) {
      currentImageUrl = url;
      _progress.add(true);
      try {
        Uint8List image = await FileStorage.loadThumbnailCachePhoto(sha, resolution: resolution);
        if (image != null) {
          _photo.add(MySuccessResult(image));
        } else {
          _photo.add(
              MyErrorResult<Uint8List>.exception(Exception("could not load image into cache")));
          if (allowDownloadFromNetwork == true) {
            image = await downloadPhotoFromNetwork(url);
            await FileStorage.saveCachePhoto(image, photoSha: sha);
            await FileStorage.saveThumbnailCachePhoto(image, photoSha: sha, resolution: resolution);
            if (resolution != PhotoResolution.HIGH) {
              image = await FileStorage.loadThumbnailCachePhoto(sha, resolution: resolution);
            }
            _photo.add(MySuccessResult(image));
          }
        }

        _progress.add(false);
      } catch (error, st) {
        _progress.add(false);
        _photo.add(MyErrorResult<Uint8List>.exception(error));
        Log.error("Error($error)\n$st");
      }
    }
  }

  Future<Uint8List> downloadPhotoFromNetwork(String url) async {
    final options = Options(
      responseType: ResponseType.bytes,
      followRedirects: false,
    );
    final response = await new Dio().get(url, options: options);
    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data as List<int>);
    }
    return Future.value(null);
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _photo.close();
    _progress.close();
  }
}
