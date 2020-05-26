import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SearchSongState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: ImageHelper.getImage('${state.songs[index].picUrl}?param=100y100', height: 35, isRound: true),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          dense: true,
          title: Text('${state.songs[index].name}'),
          subtitle: Text('${state.songs[index].singer}'),
          onTap: () {
            dispatch(SearchSongActionCreator.playSong(index));
          },
        );
      },
      itemCount: state.songs.length,
    ),
  );
}
