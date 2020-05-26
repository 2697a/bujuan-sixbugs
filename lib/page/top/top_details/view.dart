import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/top/top_details/action.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    TopDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Widgets.blackWidget(null, state.showLoading
        ? LoadingPage()
        : Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: <Widget>[
          AppBar(title: Text('网易排行榜'),backgroundColor: Colors.transparent,),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    contentPadding:
                    EdgeInsets.only(left: 5, top: 0, bottom: 0),
//                      leading: ImageHelper.getImage('${state.list[index].picUrl??''}?param=100y100',
//                          height: 35, isRound: true),
                    title: Row(
                      children: <Widget>[
                        Text(
                          '${index + 1}. ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: Screens.text14,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(state.list[index].name,style: TextStyle(fontSize: Screens.text14),maxLines: 1,overflow: TextOverflow.ellipsis,))
                      ],
                    ),
                    subtitle: Text(
                      state.list[index].singer,
                      style: TextStyle(fontSize: Screens.text12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: state.list[index].mv == 0
                        ? Container(
                      width: 0,
                    )
                        : IconButton(
                        icon: Icon(
                          Icons.videocam,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.of(viewService.context)
                              .pushNamed('mv_play', arguments: {
                            'mvId': state.list[index].mv
                          }); //注意2
                        }),
                    onTap: () {
                      dispatch(TopDetailsActionCreator.onPlaySong(index));
                    },
                  );
                },
                itemCount: state.list.length,
              )),
          PlayBarPage().buildPage(null)
        ],
      ),
    )),
  );
}
