import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/bujuan_find/action.dart';
import 'package:bujuan/widget/bujuan_head.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_easyrefresh/taurus_header.dart';

import 'state.dart';

Widget buildView(
    NewFindState state, Dispatch dispatch, ViewService viewService) {
  return state.isShowLoad
      ? LoadingPage()
      : Container(
          child: EasyRefresh.custom(
              header: TaurusHeader(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: viewService.buildComponent('banner'),
                ),
                SliverToBoxAdapter(
                  child: viewService.buildComponent('sheet'),
                ),
                SliverToBoxAdapter(
                  child:  viewService.buildComponent('new_song'),
                )
              ],
              onRefresh: () => dispatch(NewFindActionCreator.onGetRefresh())),
        );
}
