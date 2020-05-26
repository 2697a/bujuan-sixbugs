import 'dart:async';
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
  return combineEffects(<Object, Effect<MineState>>{
    MineAction.login: _onLogin,
    Lifecycle.initState: _init,
    MineAction.getRefresh: _getRefresh,
    MineAction.exit: _exit
  });
}

Future<void> _getRefresh(Action action, Context<MineState> ctx) async {
  Future.delayed(Duration(milliseconds: 500), () async {
    await _onRefresh(action, ctx);
  });
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

void _exit(Action action, Context<MineState> ctx) async{
  SpUtil.putInt(USER_ID, null);
  Navigator.pop(ctx.context);
  ctx.dispatch(MineActionCreator.changeLoginState());
}

Future _onRefresh(Action action, Context<MineState> ctx) async {
  var login = ctx.state.isLogin;
  var userId = SpUtil.getInt(USER_ID);
  if (login) {
    var list2 = await Future.wait([_getProfile(userId), _getPlayList(userId)]);
    await _getLoveSong(userId);
    list2.forEach((data) {
      if (data is UserProfileEntity) {
        if (data != null) {
          ctx.dispatch(MineActionCreator.getUserProfile(data));
        }
      }
      if (data is UserOrderEntity) {
        List<UserOrderPlaylist> createList = List();
        List<UserOrderPlaylist> collList = List();
        if (data != null) {
          Future.forEach(data.playlist, (list) async {
            if (list.creator.userId == userId) {
              createList.add(list);
            } else {
              collList.add(list);
            }
          });
          ctx.dispatch(MineActionCreator.getOrderList(collList));
          ctx.dispatch(MineActionCreator.getCreateOrderList(createList));
        }
      }
    });
  }
}

void _init(Action action, Context<MineState> ctx) async {
  Future.delayed(Duration(milliseconds: 300), () async {
    await _onRefresh(action, ctx);
  });
}

Future<UserProfileEntity> _getProfile(userId) async {
//  Response profile = await HttpUtil().post('/user/detail',data: {'uid': userId});
  var profile =
      await user_detail({'uid': userId}, await BuJuanUtil.getCookie());
  return profile.status == 200
      ? UserProfileEntity.fromJson(Map<String, dynamic>.from(profile.body))
      : null;
}

Future<UserOrderEntity> _getPlayList(userId) async {
//  Response playlist = await HttpUtil().post('/user/playlist',data: {'uid': userId});
  var playlist =
      await user_playlist({'uid': userId}, await BuJuanUtil.getCookie());
  return playlist.status == 200
      ? UserOrderEntity.fromJson(Map<String, dynamic>.from(playlist.body))
      : null;
}

///likelist
Future<void> _getLoveSong(id) async {
//  Response likeList = await HttpUtil().post('/likelist',data: {'uid': id});
  var likeList = await likelist({'uid': id}, await BuJuanUtil.getCookie());
  var likeSongListEntity = LikeSongListEntity.fromJson(Map<String, dynamic>.from(likeList.body));
  List<String> likes = List();
  likeSongListEntity.ids.forEach((id) {
    likes.add('$id');
  });
  SpUtil.putStringList(LIKE_SONGS, likes);
}
