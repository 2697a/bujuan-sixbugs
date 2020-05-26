import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SearchMvState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: ImageHelper.getImage('${state.mvs[index].cover}?param=100y100', height: 35, isRound: true),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          dense: true,
          title: Text('${state.mvs[index].name}'),
          subtitle: Text(
            '${state.mvs[index].artistName}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          onTap: () {
            Navigator.of(viewService.context).pushNamed('mv_play', arguments: {'mvId': state.mvs[index].id}); //注意2
          },
        );
      },
      itemCount: state.mvs.length,
    ),
  );
}
