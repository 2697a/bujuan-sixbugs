import 'dart:convert';

import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/page/bujuan_find/banner/state.dart';
import 'package:bujuan/page/bujuan_find/new_song/state.dart';
import 'package:bujuan/page/bujuan_find/sheet/state.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

class NewFindState implements Cloneable<NewFindState> {
  NewBannerState bannerState;
  SheetViewState sheetViewState;
  NewSongState newSongState;
  bool isShowLoad;

  @override
  NewFindState clone() {
    return NewFindState()
      ..bannerState = bannerState
      ..sheetViewState = sheetViewState
      ..newSongState = newSongState
      ..isShowLoad = isShowLoad;
  }
}

NewFindState initState(Map<String, dynamic> args) {
  var newFindState = NewFindState();
  newFindState.isShowLoad = true;
//  var sheet = SpUtil.getString('sheet',defValue: '');
//  var banner = SpUtil.getString('banner',defValue: '');
//  var newSong = SpUtil.getString('newSong',defValue: '');
//  if (banner.isNotEmpty && sheet.isNotEmpty && newSong.isNotEmpty) {
//    //banner数据缓存
//    BannerEntity bannerEntity = BannerEntity.fromJson(jsonDecode(banner));
//    newFindState.bannerState = NewBannerState().clone()..banners = bannerEntity.banners;
//    //sheet数据缓存
//    PersonalEntity personalEntity = PersonalEntity.fromJson(jsonDecode(sheet));
//    newFindState.sheetViewState = SheetViewState().clone()..result = personalEntity.result;
//    List responseJson = json.decode(newSong);
//    newFindState.newSongState = NewSongState().clone()..result = responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList();
//    newFindState.isShowLoad = false;
//  } else {
//    newFindState.sheetViewState = SheetViewState().clone()..result = [];
//    newFindState.newSongState = NewSongState().clone()..result = [];
//    newFindState.bannerState = NewBannerState().clone();
//  }
  return newFindState;
}

class BannerConnector extends ConnOp<NewFindState, NewBannerState> {
  @override
  NewBannerState get(NewFindState state) {
    return state.bannerState;
  }

  @override
  void set(NewFindState state, NewBannerState subState) {
    state.bannerState = subState;
  }
}

class SheetConnector extends ConnOp<NewFindState, SheetViewState> {
  @override
  SheetViewState get(NewFindState state) {
    return state.sheetViewState;
  }

  @override
  void set(NewFindState state, SheetViewState subState) {
    state.sheetViewState = subState;
  }
}

class NewSongConnector extends ConnOp<NewFindState, NewSongState> {
  @override
  NewSongState get(NewFindState state) {
    return state.newSongState;
  }

  @override
  void set(NewFindState state, NewSongState subState) {
    state.newSongState = subState;
  }
}
