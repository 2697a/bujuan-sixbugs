import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:bujuan/widget/loading_page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SheetSquareDetailsState state, Dispatch dispatch, ViewService viewService) {
  return state.showLoading
      ? LoadingPage()
      : Container(
          child: EasyRefresh.custom(
            footer: MaterialFooter(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: Screens.width5),
                      leading: ImageHelper.getImage('${state.playlists[index].coverImgUrl}?param=100y100', height: 42, isRound: true),
                      subtitle: Text('${state.playlists[index].trackCount} 首歌曲  Play: ${state.playlists[index].playCount > 10000 ? '${(state.playlists[index].playCount / 10000).toStringAsFixed(1)}w' : state.playlists[index].playCount}',
                        style: TextStyle(fontSize: Screens.text12),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      title: Text(state.playlists[index].name,
                        style: TextStyle(fontSize: Screens.text14),overflow: TextOverflow.ellipsis,),
                      onTap: () {
                        Navigator.of(viewService.context).pushNamed('sheet_details', arguments: {'sheetId': state.playlists[index].id}); //注意
                      },
                    );
                  },
                  childCount: state.playlists.length,
                ),
              )
            ],
            onLoad: () => dispatch(SheetSquareDetailsActionCreator.loadNextTalk()),
          ),
        );
}
