import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/search_hot_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<SearchState> buildEffect() {
  return combineEffects(<Object, Effect<SearchState>>{
    Lifecycle.initState: _init,
    SearchAction.doSearch: _doSearch,
  });
}

void _init(Action action, Context<SearchState> ctx) {
  _hotSearch().then((search) {
    if (search != null) ctx.dispatch(SearchActionCreator.onAction(search.data));
  });
}

void _doSearch(Action action, Context<SearchState> ctx) {
  Navigator.pushNamed(ctx.context, 'search_details', arguments: {'searchContent': action.payload});
}

Future<SearchHotEntity> _hotSearch() async {
  var answer = await search_hot_details({},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SearchHotEntity.fromJson(answer.body) : null;
}
