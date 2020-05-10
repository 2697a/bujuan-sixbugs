import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/local_sheet.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LocalListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 5),
            title: Row(
              children: <Widget>[
                Text(
                  '${index + 1}. ',
                  style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(state.list[index].name)
              ],
            ),
            subtitle: Text(state.list[index].singer),
            trailing: IconButton(
              icon: Icon(
                Icons.edit_attributes,
                size: 20,
              ),
              onPressed: () {
                addSongToSheet(viewService, state.list[index]);
              },
            ),
            onTap: () {
              dispatch(LocalListActionCreator.playLocal(index));
            },
          );
        },
        itemCount: state.list.length,
      ),
    ),
  );
}

void addSongToSheet(viewService, SongBeanEntity songBeanEntity) {
  var string = SpUtil.getString(LOCAL_SHEET, defValue: '');
  List responseJson = json.decode(string);
  List<LocalSheetEntity> sheets = responseJson.map((m) => new LocalSheetEntity.fromJson(m)).toList();
  showBujuanBottomSheet(
    context: viewService.context,
    builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.height;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: width / 1.8,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('添加歌曲到歌单'),
              contentPadding: EdgeInsets.all(0),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    Icons.album,
                    size: 20,
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        '${index + 1}. ',
                        style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(sheets[index].name)
                    ],
                  ),
                  onTap: () {
                    var string = SpUtil.getString('${sheets[index].id}', defValue: '');
                    List<SongBeanEntity> songs = List();
                    if (string != '') {
                      List responseJson = json.decode(string);
                      songs.addAll(responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList());
                    }
                    int indexWhere = songs.indexWhere((item) => item.id == songBeanEntity.id);
                    if (indexWhere == -1) songs.add(songBeanEntity);
                    SpUtil.putString('${sheets[index].id}', jsonEncode(songs));
                    Navigator.pop(viewService.context);
                  },
                );
              },
              itemCount: sheets.length,
            ))
          ],
        ),
      );
    },
  );
}
