import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/page/hot_singer/singer_details/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    SingerDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: state.isShowLoading
        ? LoadingPage()
        : DefaultTabController(
            length: state.tabs.length,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    child: SliverAppBar(
                      title: Text(state.artistBean.name),
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
                              height: 260,
                              child: ImageHelper.getImage(
                                  state.artistBean.picUrl + "?param=400y400",
                                  height: 230),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants.dark
                                      ? Colors.grey[850].withOpacity(.3)
                                      : Colors.white.withOpacity(.3)),
                            ),
                          ],
                        ),
                      ),

                      bottom: TabBar(
                        tabs: state.tabs
                            .map((String name) => Tab(text: name))
                            .toList(),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                  // These are the contents of the tab views, below the tabs.
                  children: <Widget>[
                    songView(state, dispatch, viewService),
                    albumView(state, dispatch, viewService),
                    Center(
                      child: Text('暂未完善'),
                    )
                  ]),
            ),
          ),
  );
}

Widget songView(
    SingerDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      return CustomScrollView(
        key: PageStorageKey<String>('song'),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    dense: true,
                    contentPadding:
                        EdgeInsets.only(left: 5, right: 0, top: 0, bottom: 0),
                    title: Row(
                      children: <Widget>[
                        Text(
                          '${index + 1}. ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: Screens.text14,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Text(
                          '${state.songs[index].name}',
                          style: TextStyle(fontSize: Screens.text14),
                          maxLines: 1,
                        ))
                      ],
                    ),
                    subtitle: Text(
                      '${state.songs[index].singer}',
                      style: TextStyle(fontSize: Screens.text12),
                      maxLines: 1,
                    ),
                    trailing: state.songs[index].mv == 0
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.videocam,
                              size: Screens.text18,
                            ),
                            onPressed: () {
                              Navigator.of(viewService.context)
                                  .pushNamed('mv_play', arguments: {
                                'mvId': state.songs[index].mv
                              }); //注意2
                            }),
                    onTap: () {
                      dispatch(SingerDetailsActionCreator.onPlaySong(index));
                    },
                  );
                },
                childCount: state.songs.length,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget albumView(
    SingerDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      return state.albums == null
          ? LoadingPage()
          : CustomScrollView(
              key: PageStorageKey<String>('album'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(
                              left: 5, right: 0, top: 0, bottom: 0),
                          title: Row(
                            children: <Widget>[
                              Text(
                                '${index + 1}. ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: Screens.text14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                '${state.albums[index].name}',
                                style: TextStyle(fontSize: Screens.text14),
                                maxLines: 1,
                              ))
                            ],
                          ),
                          subtitle: Text(
                            '${state.albums[index].size}',
                            style: TextStyle(fontSize: Screens.text12),
                            maxLines: 1,
                          ),
                          onTap: () {
                            dispatch(
                                SingerDetailsActionCreator.onPlaySong(index));
                          },
                        );
                      },
                      childCount: state.songs.length,
                    ),
                  ),
                ),
              ],
            );
    },
  );
}
