import 'package:bujuan/page/search/search_mv/page.dart';
import 'package:bujuan/page/search/search_sheet/page.dart';
import 'package:bujuan/page/search/search_singer/page.dart';
import 'package:bujuan/page/search/search_song/page.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:bujuan/widget/play_bar/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SearchDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: BujuanAppBar.norAppBar(viewService.context,'Search: "${ state.searchContent}"'),
    body: state.showLoading
        ? LoadingPage()
        : Container(
            child: DefaultTabController(
                length: 4,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      labelPadding: EdgeInsets.all(0),
                      tabs: <Widget>[
                        Tab(text: '单曲'),
                        Tab(text: '歌单'),
                        Tab(text: '歌手'),
                        Tab(text: 'mv'),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(children: <Widget>[
                      SearchSongPage().buildPage({'songs': state.songs}),
                      SearchSheetPage().buildPage({'sheets': state.playlists}),
                      SearchSingerPage().buildPage({'singers': state.artists}),
                      SearchMvPage().buildPage({'mvs': state.mvs}),
                    ])),
                    PlayBarPage().buildPage(null)
                  ],
                )),
          ),
  );
}
