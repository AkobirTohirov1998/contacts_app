import 'package:first_app/common/photo_resolution.dart';
import 'package:first_app/resources/colors.dart';
import 'package:first_app/widgets/container.dart';
import 'package:first_app/widgets/my_cache_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/widgets/icon.dart';

// ignore: must_be_immutable
class VAvatar extends VContainer {
  final String imageUrl;
  final double size;
  final EdgeInsetsGeometry margin;

  VAvatar({
    @required this.imageUrl,
    this.size = 70,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = ClipRRect(
      child: Container(
        width: size,
        height: size,
        child: Stack(
          children: [
            if (imageUrl?.isNotEmpty == true)
              const SizedBox(
                child: CircularProgressIndicator(strokeWidth: 2),
                width: 20,
                height: 20,
              ),
            if (imageUrl?.isNotEmpty == true)
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
            if (imageUrl?.isNotEmpty != true)
              MyIcon.icon(Icons.person_rounded, color: ExampleColor.getColor().block.surface_2),
          ],
          alignment: AlignmentDirectional.center,
        ),
        color: ExampleColor.getColor().block.background,
      ),
      borderRadius: BorderRadius.circular(100),
    );

    if (margin != null) {
      widget = Padding(padding: margin, child: widget);
    }

    return widget;
  }
}

class GLAvatar extends VContainer {
  final String imageUrl;
  final String photoSha;
  final double size;
  final EdgeInsetsGeometry margin;
  final Widget Function(BuildContext) emptyAvatarWidget;
  final PhotoResolution photoResolution;

  GLAvatar({
    @required this.imageUrl,
    @required this.photoSha,
    this.size = 70,
    this.photoResolution,
    this.margin,
    this.emptyAvatarWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = ClipRRect(
      child: Container(
        width: size,
        height: size,
        child: MyCachePhotoWidget(imageUrl,
            photoSha: photoSha,
            fit: BoxFit.cover,
            width: size,
            height: size,
            photoResolution: getPhotoResolution(),
            errorWidgetBuilder: emptyAvatarWidget,
            allowDownloadFromNetwork: true),
        color: ExampleColor.getColor().accent,
      ),
      borderRadius: BorderRadius.circular(100),
    );

    if (margin != null) {
      widget = Padding(padding: margin, child: widget);
    }

    return widget;
  }

  PhotoResolution getPhotoResolution() {
    if (photoResolution != null) return photoResolution;

    if (size <= 100)
      return PhotoResolution.LOW;
    else if (size <= 480)
      return PhotoResolution.NORMAL;
    else
      return PhotoResolution.HIGH;
  }
}
