import 'package:bujuan/widget/back_widget.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HotSingerState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Widgets.blackWidget(null, state.showLoading
        ? LoadingPage()
        : Container(
      child: EasyRefresh.custom(
        footer: MaterialFooter(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: AppBar(
              title: Text('热门歌手'),
              backgroundColor: Colors.transparent,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  leading: ImageHelper.getImage(
                      '${state.artists[index].picUrl}?param=100y100',
                      height: 42,
                      isRound: true),
                  title: Text('${state.artists[index].name}'),
                  subtitle: Text('${state.artists[index].musicSize} 首单曲'),
                  onTap: () async {
                    await Navigator.of(viewService.context)
                        .pushNamed('singer_details', arguments: {
                      'id': state.artists[index].id
                    });
                  },
                );
              },
              childCount: state.artists.length,
            ),
          )
        ],
        onLoad: () => dispatch(HotSingerActionCreator.onLoad()),
      ),
    )),
  );
}
