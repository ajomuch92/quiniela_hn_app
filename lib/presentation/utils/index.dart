import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';

class ToastMetaData {
  final Color? color;
  final IconData? iconData;

  const ToastMetaData({this.color, this.iconData});
}

enum ToastType {
  info(ToastMetaData(color: GFColors.INFO, iconData: Glyphicon.info)),
  warning(ToastMetaData(color: GFColors.WARNING, iconData: Glyphicon.exclamation_triangle_fill)),
  success(ToastMetaData(color: GFColors.SUCCESS, iconData: Glyphicon.check_circle_fill)),
  danger (ToastMetaData(color: GFColors.DANGER, iconData: Glyphicon.x_circle_fill));

  const ToastType(this.metaData);
  final ToastMetaData metaData;
}

void showDangerToast(BuildContext context, String message, ToastType toastType) {
    GFToast.showToast(
      message,
      context,
      toastPosition: GFToastPosition.TOP,
      backgroundColor: GFColors.DARK,
      toastBorderRadius: 10.0,
      trailing: Icon(
        toastType.metaData.iconData,
        color: toastType.metaData.color,
      )
    );
  }