import 'package:first_app/common/resources.dart';
import 'package:first_app/widgets/my_cache_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class AccountAvatarWidget extends StatelessWidget {
  double radius;
  String imageUrl;
  String imageSha;
  IconData avatarIcon;
  String avatarIconSrc;
  final bool isSelected;

  AccountAvatarWidget({
    this.radius,
    this.imageUrl,
    this.imageSha,
    this.avatarIcon,
    this.avatarIconSrc,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (radius == null || radius == 0 || radius < 0) {
      radius = 20;
    }

    Widget widget;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      widget = ClipRRect(
        child: MyCachePhotoWidget(
          imageUrl,
          photoSha: imageSha,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );
    } else {
      widget = CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black26,
        child: CircleAvatar(
            radius: radius - 1,
            backgroundColor: Colors.grey[100],
            child: avatarIconSrc?.isNotEmpty == true
                ? MyIcon.svg(
                    avatarIconSrc,
                    size: radius + 10,
                    color: Colors.grey[400],
                  )
                : Icon(
                    avatarIcon ?? Icons.person,
                    size: radius + 10,
                    color: Colors.grey[400],
                  )),
      );
    }

    if (isSelected) {
      widget = Stack(
        children: <Widget>[
          widget,
          Positioned(
            bottom: 0,
            right: 0,
            child: ContainerElevation(
              const Icon(Icons.done, size: 5, color: Colors.white),
              backgroundColor: AssertsColors.green_light,
              width: 12,
              height: 12,
              borderRadius: BorderRadius.circular(6),
            ),
          )
        ],
      );
    }

    return widget;
  }
}
