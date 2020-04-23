import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

Widget buildView(
    PersonalResult state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    child: Container(
      child: Column(
        children: <Widget>[
          ImageHelper.getImage(
              state.picUrl == null ? null : state.picUrl + "?param=250y250",),
          Container(
            padding: EdgeInsets.only(top: Screens.height5),
            alignment: Alignment.center,
            child: Text(
              state.name,
              style: TextStyle(fontSize: 13,height: 1.2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
    onTap: () {
      Navigator.of(viewService.context)
          .pushNamed('sheet_details', arguments: {'sheetId': state.id}); //注意2
    },
  );
}
