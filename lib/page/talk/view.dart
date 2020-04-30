import 'package:bujuan/entity/song_talk_entity.dart';
import 'package:bujuan/page/talk/action.dart';
import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';

import 'state.dart';

Widget buildView(TalkState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down),
          onPressed: () {
            Navigator.pop(viewService.context);
          }),
      title: Text('评论'),
    ),
    body: state.showLoading
        ? LoadingPage()
        : Container(
      padding: EdgeInsets.only(left: 10, right: 5, bottom: 3),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      child: TextField(
                        controller: state.textEditingController,
                        decoration: InputDecoration(isDense: true, hintText: '祝你说出热评', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8)),
                      ),
                    )),
                IconButton(icon: Icon(Icons.send), onPressed: () {
                  dispatch(TalkActionCreator.sendTalk());
                })
              ],
            ),
          ),
          Expanded(
              child: EasyRefresh.custom(
                footer: MaterialFooter(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        child: Text(
                          '精彩评论',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5, top: 20, bottom: 10)),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return _talkHotItem(state.hotComments[index]);
                      },
                      childCount: state.hotComments.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        child: Text(
                          '最新评论',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5, top: 20, bottom: 5)),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return _talkItem(state.comments[index]);
                      },
                      childCount: state.comments.length,
                    ),
                  )
                ],
                onLoad: () => dispatch(TalkActionCreator.loadNextTalk()),
              )),
        ],
      ),
    ),
  );
}

Widget _talkHotItem(SongTalkHotcommants hotcommants) {
  return Container(
    child: Wrap(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 10),
          dense: true,
          leading: ImageHelper.getImage(hotcommants.user.avatarUrl + "?param=80y80", height: 35, isRound: true),
          title: Text(hotcommants.user.nickname, style: TextStyle(color: Colors.grey)),
          subtitle: Text('${DateTime.fromMillisecondsSinceEpoch(hotcommants.time)}', style: TextStyle(color: Colors.grey)),
          trailing: Text(
            '${hotcommants.likedCount > 10000 ? '${(hotcommants.likedCount / 10000).toStringAsFixed(1)}w' : hotcommants.likedCount} 赞',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 55, right: 10),
          child: Text(
            hotcommants.content,
            style: TextStyle(height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _talkItem(SongTalkCommants commants) {
  return Container(
    child: Wrap(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 10),
          dense: true,
          leading: ImageHelper.getImage(commants.user.avatarUrl + "?param=80y80", height: 35, isRound: true),
          title: Text(
            commants.user.nickname,
            style: TextStyle(color: Colors.grey),
          ),
          subtitle: Text('${DateTime.fromMillisecondsSinceEpoch(commants.time)}', style: TextStyle(color: Colors.grey)),
          trailing: Text(
            '${commants.likedCount > 10000 ? '${(commants.likedCount / 10000).toStringAsFixed(1)}w' : commants.likedCount} 赞',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 55, right: 10),
          child: Text(
            commants.content,
            style: TextStyle(height: 1.5),
          ),
        ),
      ],
    ),
  );
}
