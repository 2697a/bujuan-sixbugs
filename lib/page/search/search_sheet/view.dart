import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SearchSheetState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: ImageHelper.getImage('${state.playlists[index].coverImgUrl}?param=100y100', height: 35,isRound: true),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          dense: true,
          title: Text('${state.playlists[index].name}'),
          subtitle: Text('${state.playlists[index].trackCount} 首单曲',overflow: TextOverflow.ellipsis,maxLines: 1,),
          onTap: (){
            Navigator.of(viewService.context)
                .pushNamed('sheet_details', arguments: {'sheetId': state.playlists[index].id}); //注意2
          },
        );
      },
      itemCount: state.playlists.length,
    ),
  );
}
