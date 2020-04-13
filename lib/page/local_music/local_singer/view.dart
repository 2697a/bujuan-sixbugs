import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/local_music/local_list/page.dart';
import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    LocalSingerState state, Dispatch dispatch, ViewService viewService) {
  return state.map == null
      ? Container()
      : Container(
          child: GridView.count(
          //水平子Widget之间间距
          crossAxisSpacing: 10.0,
          //垂直子Widget之间间距
          mainAxisSpacing: 10.0,
          //GridView内边距
          //一行的Widget数量
          crossAxisCount: 2,
          //子Widget宽高比例
          childAspectRatio: 2.1,
          //子Widget列表
          children: _items(state, viewService),
        ));
}

List<Widget> _items(LocalSingerState state, ViewService viewService) {
  List<Widget> w = List();
  state.map.forEach((key, List<SongBeanEntity> value) {
    w.add(Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        leading: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(51, 105, 232, 0.5),
            borderRadius: BorderRadius.circular(35.0)
          ),
          height: 40,
          width: 40,
          child: Text('${key.substring(0, 1)}',style: TextStyle(fontSize: 20),),
          alignment: Alignment.center,
        ),
        title: Text('$key'),
        subtitle: Text('${value.length} 首單曲'),
        onTap: () {
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
                      title: Text('歌手：$key'),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    Expanded(child: LocalListPage().buildPage({'list': value}))
                  ],
                ),
              );
            },
          );
        },
      ),
    ));
  });
  return w;
}
