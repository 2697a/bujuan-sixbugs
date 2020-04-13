import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/local_sheet.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class LocalSheetListState implements Cloneable<LocalSheetListState> {
  List<LocalSheetEntity> list;

  TextEditingController textEditingController;

  @override
  LocalSheetListState clone() {
    return LocalSheetListState()
      ..textEditingController = textEditingController
      ..list = list;
  }
}

LocalSheetListState initState(Map<String, dynamic> args) {
  var localSheetListState = LocalSheetListState();
  localSheetListState.textEditingController = TextEditingController();
  localSheetListState.list = [];
  return localSheetListState;
}
