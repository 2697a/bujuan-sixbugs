import 'dart:convert';

import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/local_music/local_list/page.dart';
import 'package:bujuan/page/local_music/local_sheet_list/action.dart';
import 'package:bujuan/page/local_music/local_singer/action.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(LocalSheetListState state, Dispatch dispatch, ViewService viewService) {
  var width2 = MediaQuery.of(viewService.context).size.width;
  return Container(
      child: Column(
    children: <Widget>[
      ListTile(
        dense: true,
        leading: Icon(Icons.add),
        title: Text('添加本地歌單'),
        onTap: () {
          addSheet(state, dispatch, viewService);
        },
        contentPadding: EdgeInsets.only(top: 5, bottom: 5),
      ),
      state.list.length > 0
          ? Expanded(
              child: ListView.builder(
              padding: EdgeInsets.all(0),
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
                      Text(state.list[index].name)
                    ],
                  ),
                  trailing: state.list[index].id != '001'
                      ? IconButton(
                          icon: Icon(
                            Icons.delete_sweep,
                            size: 20,
                          ),
                          onPressed: () {
                            showDialog(
                              context: viewService.context,
                              builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), title: Text("刪除歌单"), content: Text("確定刪除名爲:${state.list[index].name}的歌单吗"), actions: <Widget>[
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    child: Text('确认'),
                                  ),
                                  onTap: () {
                                    dispatch(LocalSheetListActionCreator.del(state.list[index].id));
                                  },
                                )
                              ]),
                            );
                          })
                      : Text(''),
                  onTap: () {
                    var string = SpUtil.getString('${state.list[index].id}', defValue: '');
                    List<SongBeanEntity> songs = List();
                    if (string != '') {
                      List responseJson = json.decode(string);
                      songs.addAll(responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList());
                    }
                    showBujuanBottomSheet(
                      context: viewService.context,
                      builder: (BuildContext context) {
                        var width = MediaQuery.of(context).size.height;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          height: width / 1.2,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text('${state.list[index].name}'),
                                contentPadding: EdgeInsets.all(0),
                              ),
                              Expanded(child: LocalListPage().buildPage({'list': songs}))
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              itemCount: state.list.length,
            ))
          : Expanded(
              child: Center(
              child: Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(
                    width: width2 - 30,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                    ),
                  ),
                  Container(
                    width: width2 - 30,
                    child: Text(
                      '暂无本地歌單',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                  ),
                ],
              ),
            ))
    ],
  ));
}

void addSheet(LocalSheetListState state, Dispatch dispatch, ViewService viewService) {
  showDialog(
    context: viewService.context,
    builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text("创建本地歌单"),
        titlePadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        content: Container(
          margin: EdgeInsets.all(15),
          child: Card(
            elevation: 2,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              controller: state.textEditingController,
              decoration: InputDecoration(isDense: true, hintText: '输入歌单名称', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8)),
            ),
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('确认'),
            ),
            onTap: () {
              dispatch(LocalSheetListActionCreator.onAction());
            },
          )
        ]),
  );
}
