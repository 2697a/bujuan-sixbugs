//import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_loaed.dart';

class SaveData {
  static List<SongBeanEntity> readyList;
}

class ImageHelper {
  /// 获取默认image
  static Widget getImage(String imageUrl, {double height, bool isRound}) {
    if (isRound == null) isRound = false;
    if (imageUrl != null && imageUrl.substring(0, 1) != '?') {
      bool netPath = imageUrl.substring(0, 4) == 'http';
      if (!netPath) imageUrl = imageUrl.split('?')[0];
      return ClipRRect(
        borderRadius: BorderRadius.circular(isRound ? height : 5.0),
        child: netPath
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: height,
                width: height,
//                placeholder: (context, url) => new Container(
//                  height: height,
//                  width: height,
//                  alignment: Alignment.center,
//                  child: ColorLoader3(
//                    radius: 20.0,
//                    dotRadius: 3.0,
//                  ),
//                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : Image.file(
                File(imageUrl),
                height: height,
                width: height,
                fit: BoxFit.cover,
              ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(isRound ? height : 6.0),
          child: Container(
            child: Image.asset(
              'assets/images/logo.png',
              height: height,
              width: height,
              fit: BoxFit.fill,
            ),
          ));
    }
  }

  /// 获取默认image
  static Widget getImageNoRound(String imageUrl, {double height}) {
    if (imageUrl != null && imageUrl.substring(0, 1) != '?') {
      bool netPath = imageUrl.substring(0, 4) == 'http';
      if (!netPath) imageUrl = imageUrl.split('?')[0];
      return netPath
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              height: height,
              width: height,
//              placeholder: (context, url) => new Container(
//                height: height,
//                width: height,
//                alignment: Alignment.center,
//                child: ColorLoader3(
//                  radius: 20.0,
//                  dotRadius: 3.0,
//                ),
//              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Image.file(
              File(imageUrl),
              height: height,
              width: height,
              fit: BoxFit.cover,
            );
    } else {
      return Container(
        child: Image.asset(
          'assets/images/logo.png',
          height: height,
          width: height,
          fit: BoxFit.fill,
        ),
      );
    }
  }

  /// 获取默认image
  static Widget getOtherImage(
    String imageUrl, {
    double height,
    bool isRound,
  }) {
    if (isRound == null) isRound = false;
    if (imageUrl != null && imageUrl.substring(0, 1) != '?') {
      bool netPath = imageUrl.substring(0, 4) == 'http';
      if (!netPath) imageUrl = imageUrl.split('?')[0];
      return ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(height),
            bottomRight: Radius.circular(height)),
        child: netPath
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: height,
                width: height,
//                placeholder: (context, url) => new Container(
//                  height: height,
//                  width: height,
//                  alignment: Alignment.center,
//                  child: ColorLoader3(
//                    radius: 20.0,
//                    dotRadius: 3.0,
//                  ),
//                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : Image.file(
                File(imageUrl),
                height: height,
                width: height,
                fit: BoxFit.cover,
              ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(isRound ? height : 6.0),
          child: Container(
            child: Image.asset(
              'assets/images/logo.png',
              height: height,
              width: height,
              fit: BoxFit.fill,
            ),
          ));
    }
  }
}
