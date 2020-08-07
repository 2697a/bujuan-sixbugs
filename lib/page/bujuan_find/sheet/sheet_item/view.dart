import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

Widget buildView(PersonalResult state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(.1), borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: <Widget>[
          ImageHelper.getImage(
            state.picUrl == null ? null : state.picUrl + "?param=250y250",
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              state.name,
              style: TextStyle(fontSize: 14, height: 1.2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ))
        ],
      ),
    ),
    onTap: () {
      Navigator.of(viewService.context).pushNamed('sheet_details', arguments: {'sheetId': state.id}); //注意2
    },
  );
}
