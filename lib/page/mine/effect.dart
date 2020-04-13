import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/like_song_list_entity.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';
import 'package:flutter/widgets.dart' hide Action; //注意1

Effect<MineState> buildEffect() {
  return combineEffects(<Object, Effect<MineState>>{MineAction.login: _onLogin, Lifecycle.initState: _init, MineAction.getRefresh: _getRefresh, MineAction.exit: _exit});
}

Future<void> _getRefresh(Action action, Context<MineState> ctx) async {
  _onRefresh(action, ctx);
}

//点击登录
void _onLogin(Action action, Context<MineState> ctx) {
  Navigator.of(ctx.context).pushNamed('login', arguments: null).then((login) {
    if (login != null) {
      ctx.dispatch(MineActionCreator.onLoginResult(true));
      _init(action, ctx);
    }
  });
}

void _exit(Action action, Context<MineState> ctx) {
  SpUtil.putInt(Constants.USER_ID, null);
  Navigator.pop(ctx.context);
  ctx.dispatch(MineActionCreator.changeLoginState());
}

void _onRefresh(Action action, Context<MineState> ctx) {
  var login = ctx.state.isLogin;
  var userId = SpUtil.getInt(Constants.USER_ID);
  if (login) {
    _getLoveSong(userId);
    _getProfile(userId).then((profile) {
      if (profile != null) {
        SpUtil.putString('profile', jsonEncode(profile));
        ctx.dispatch(MineActionCreator.getUserProfile(profile));
      }
    });
    List<UserOrderPlaylist> createList = List();
    List<UserOrderPlaylist> collList = List();
    _getPlayList(userId).then((orderList) {
      if (orderList != null) {
        orderList.playlist.forEach((list) {
          if (list.creator.userId == userId) {
            createList.add(list);
          } else {
            collList.add(list);
          }
        });
        SpUtil.putString('create', jsonEncode(createList));
        SpUtil.putString('coll', jsonEncode(collList));
        ctx.dispatch(MineActionCreator.getOrderList(collList));
        ctx.dispatch(MineActionCreator.getCreateOrderList(createList));
      }
    });
  }
}

void _init(Action action, Context<MineState> ctx) {
  //登陆了
  _onRefresh(action, ctx);
}

Future<UserProfileEntity> _getProfile(userId) async {
  var profile = await user_detail({'uid': userId}, BuJuanUtil.getCookie());
  return profile.status == 200 ? UserProfileEntity.fromJson(profile.body) : null;
}

Future<UserOrderEntity> _getPlayList(userId) async {
  var playlist = await user_playlist({'uid': userId}, BuJuanUtil.getCookie());
//  Response profile =
//      await HttpUtil().get('/user/playlist', data: {'uid': userId});
//  var data = profile.data;
//  var jsonDecode2 = jsonDecode(data);
  return playlist.status == 200 ? UserOrderEntity.fromJson(playlist.body) : null;
}

///likelist
Future<void> _getLoveSong(id) async {
  var likeList = await likelist({'uid': id}, BuJuanUtil.getCookie());
//  Response name = await HttpUtil().post('/likelist', data: {'uid': id});
//  var data = name.data;
//  var jsonDecode2 = jsonDecode(data);
  var likeSongListEntity = LikeSongListEntity.fromJson(likeList.body);
  List<String> likes = List();
  likeSongListEntity.ids.forEach((id) {
    likes.add('$id');
  });
  SpUtil.putStringList(Constants.LIKE_SONGS, likes);
}
