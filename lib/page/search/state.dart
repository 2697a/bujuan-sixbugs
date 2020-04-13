import 'package:bujuan/entity/search_hot_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class SearchState implements Cloneable<SearchState> {
  List<SearchHotData> data;
  TextEditingController textEditingController;

  @override
  SearchState clone() {
    return SearchState()..data = data..textEditingController = textEditingController;
  }
}

SearchState initState(Map<String, dynamic> args) {
  var clone = SearchState().clone();
  clone.textEditingController = TextEditingController();
  clone.data = [];
  return clone;
}
