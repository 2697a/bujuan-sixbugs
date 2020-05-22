import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    NewFindState state, Dispatch dispatch, ViewService viewService) {
//  return state.isShowLoad
//      ? LoadingPage()
//      : Container(
//          padding: EdgeInsets.symmetric(horizontal: Screens.width5),
//          child: EasyRefresh(
//              header: MaterialHeader(
//                valueColor:
//                    AlwaysStoppedAnimation(Color.fromRGBO(238, 178, 17, .6)),
//              ),
//              child: SingleChildScrollView(
//                child: Column(
//                  children: <Widget>[
//                    viewService.buildComponent('banner'),
//                    viewService.buildComponent('sheet'),
//                    viewService.buildComponent('new_song'),
//                  ],
//                ),
//              ),
//              onRefresh: () => dispatch(NewFindActionCreator.onGetRefresh())),
//        );
  return state.isShowLoad
      ? LoadingPage()
      : Container(
          padding: EdgeInsets.symmetric(horizontal: Screens.width5),
          child: EasyRefresh.custom(
              header: MaterialHeader(
                valueColor:
                    AlwaysStoppedAnimation(Color.fromRGBO(238, 178, 17, .6)),
              ),
              onRefresh: () => dispatch(NewFindActionCreator.onGetRefresh()),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: viewService.buildComponent('banner'),
                ),
                viewService.buildComponent('sheet'),
                viewService.buildComponent('new_song'),
              ]),
        );
}
