import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SearchSingerState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: ImageHelper.getImage('${state.artists[index].picUrl}?param=100y100', height: 35,isRound: true),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          dense: true,
          title: Text('${state.artists[index].name}'),
          subtitle: Text('${state.artists[index].albumSize} 张专辑',overflow: TextOverflow.ellipsis,maxLines: 1,),
          onTap: (){
          },
        );
      },
      itemCount: state.artists.length,
    ),
  );
}
