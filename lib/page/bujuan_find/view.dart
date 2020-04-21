import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/bujuan_find/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/taurus_header.dart';

import 'state.dart';

Widget buildView(
    NewFindState state, Dispatch dispatch, ViewService viewService) {
  return state.isShowLoad
      ? LoadingPage()
      : Container(
          padding: EdgeInsets.symmetric(horizontal: Screens.width5),
//          child: EasyRefresh.custom(
//              header: TaurusHeader(),
//              slivers: <Widget>[
//                SliverToBoxAdapter(
//                  child: viewService.buildComponent('banner'),
//                ),
//                SliverToBoxAdapter(
//                  child: viewService.buildComponent('sheet'),
//                ),
//                SliverToBoxAdapter(
//                  child:  viewService.buildComponent('new_song'),
//                )
//              ],
//              onRefresh: () => dispatch(NewFindActionCreator.onGetRefresh())),
          child: EasyRefresh(
            header: MaterialHeader(valueColor: AlwaysStoppedAnimation(Color.fromRGBO(238, 178, 17, .6)),),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Image.asset('assets/images/find.png',height: 140,),
                      onTap: (){
                        BuJuanUtil.showToast('点我开启本地音乐');
                      },
                    ),
                    viewService.buildComponent('sheet'),
                    viewService.buildComponent('new_song'),
                  ],
                ),
              ),
              onRefresh: () => dispatch(NewFindActionCreator.onGetRefresh())),
        );
}
