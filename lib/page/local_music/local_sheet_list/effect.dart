import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/local_sheet.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<LocalSheetListState> buildEffect() {
  return combineEffects(<Object, Effect<LocalSheetListState>>{
    LocalSheetListAction.action: _onAction,
    LocalSheetListAction.del: _onDel,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _onDel(Action action, Context<LocalSheetListState> ctx) {
  var string = SpUtil.getString(LOCAL_SHEET, defValue: '');
  List responseJson = json.decode(string);
  List<LocalSheetEntity> sheets = responseJson.map((m) => new LocalSheetEntity.fromJson(m)).toList();
  var payload = action.payload;
  sheets.removeWhere((item) {
    return item.id == payload;
  });
  var jsonEncode2 = jsonEncode(sheets);
  SpUtil.putString(LOCAL_SHEET, jsonEncode2);
  Navigator.pop(ctx.context);
  _init(action, ctx);
}

void _dispose(Action action, Context<LocalSheetListState> ctx) {
  ctx.state.textEditingController?.dispose();
}

void _onAction(Action action, Context<LocalSheetListState> ctx) {
  var text2 = ctx.state.textEditingController.text;
  if (text2 != '') {
    Navigator.pop(ctx.context);
    var string = SpUtil.getString(LOCAL_SHEET, defValue: '');
    List responseJson = json.decode(string);
    List<LocalSheetEntity> sheets = responseJson.map((m) => new LocalSheetEntity.fromJson(m)).toList();
    LocalSheetEntity localSheetEntity = LocalSheetEntity(name: text2, id: '${DateTime.now().millisecondsSinceEpoch ~/ 1000}', picUrl: '');
    sheets.add(localSheetEntity);
    var jsonEncode2 = jsonEncode(sheets);
    SpUtil.putString(LOCAL_SHEET, jsonEncode2);
    _init(action, ctx);
  }
}

void _init(Action action, Context<LocalSheetListState> ctx) {
  var string = SpUtil.getString(LOCAL_SHEET, defValue: '');
  if (string == '') {
    List<LocalSheetEntity> list = List();
    LocalSheetEntity localSheetEntity = LocalSheetEntity(name: '预设歌单~', id: '001', picUrl: '');
    list.add(localSheetEntity);
    var jsonEncode2 = jsonEncode(list);
    SpUtil.putString(LOCAL_SHEET, jsonEncode2);
    string = jsonEncode2;
  }
  List responseJson = json.decode(string);
  List<LocalSheetEntity> sheets = responseJson.map((m) => new LocalSheetEntity.fromJson(m)).toList();
  ctx.dispatch(LocalSheetListActionCreator.changList(sheets));
}
