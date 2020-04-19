import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SingerDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body:  DefaultTabController(
      length: state.tabs.length, // This is the number of tabs.
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              handle:
              NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                title:  Text(state.singerName),
                centerTitle: false,
                pinned: true,
                floating: false,
                snap: false,
                primary: true,
                expandedHeight: 230.0,
                elevation: 10,
                //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: new FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: ImageHelper.getImage(state.singerPic + "?param=400y400",height: 230),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Constants.dark?Colors.grey[850].withOpacity(.3):Colors.white.withOpacity(.3)
                        ),
                      ),
                    ],
                  ),
                ),

                bottom: TabBar(
                  tabs: state.tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          // These are the contents of the tab views, below the tabs.
          children: state.tabs.map((String name) {
            //SafeArea 适配刘海屏的一个widget
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: SliverFixedExtentList(
                          itemExtent: 50.0, //item高度或宽度，取决于滑动方向
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return ListTile(
                                title: Text('Item $index'),
                              );
                            },
                            childCount: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
