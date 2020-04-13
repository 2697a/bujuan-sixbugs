import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/top/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_easyrefresh/taurus_header.dart';

import 'state.dart';

Widget buildView(TopPageState state, Dispatch dispatch, ViewService viewService) {
  var width = MediaQuery.of(viewService.context).size.width;
  return Scaffold(
    body: state.showLoading == null || state.showLoading
        ? LoadingPage()
        : Container(
            child: EasyRefresh.custom(
              header: TaurusHeader(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5, top: 0, bottom: 0),
                    title: Text(
                      '網易排行榜',
                      style: TextStyle(fontSize: Screens.text14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _topItem(Constants.bs_top, state.bsList, '19723756', dispatch, width),
                      _topItem(Constants.new_top, state.newList, '3779629', dispatch, width),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(5)),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _topItem(Constants.yc_top, state.ycList, '2884035', dispatch, width),
                      _topItem(Constants.hot_top, state.hotList, '3778678', dispatch, width),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5, top: 0, bottom: 0),
                    title: Text(
                      '排行榜',
                      style: TextStyle(fontSize: Screens.text14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: width / 3,
                                child: ImageHelper.getImage(state.topInfos[index].picUrl, height: 120),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.only(topLeft: Radius.circular(6))),
                                padding: EdgeInsets.only(top: 5, left: 5),
                                child: Text(
                                  state.topInfos[index].name,
                                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          dispatch(TopPageActionCreator.onOpenDetail(state.topInfos[index].id));
                        },
                      );
                    },
                    childCount: state.topInfos.length,
                  ),
                )
              ],
              onRefresh: () => dispatch(TopPageActionCreator.onGetRef()),
            ),
          ),
  );
}

Widget _topItem(image, List<SongBeanEntity> songs, id, Dispatch dispatch, width) {
  return InkWell(
    child: Container(
      width: width / 2 - Screens.setWidth(10),
      padding: EdgeInsets.all(3),
      child: Column(
        children: <Widget>[
          Container(
            width: width / 2 - Screens.setWidth(10),
            child: ImageHelper.getImage(image, height: Screens.setHeight(110)),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(Screens.setWidth(5)),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${songs[index].name} (${songs[index].singer})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Screens.text12, wordSpacing: 1.2),
                ),
              );
            },
            itemCount: 3,
          )
        ],
      ),
    ),
    onTap: () {
      dispatch(TopPageActionCreator.onOpenDetail(id));
    },
  );
}

class TopInfo {
  String id;
  String name;
  String picUrl;

  TopInfo(this.id, this.name, this.picUrl);
}
