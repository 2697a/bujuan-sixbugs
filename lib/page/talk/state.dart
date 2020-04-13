import 'package:bujuan/entity/song_talk_entity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class TalkState implements Cloneable<TalkState> {
  String id;
  List<SongTalkCommants> comments;
  List<SongTalkHotcommants> hotComments;
  bool showLoading;
  int page;
  TextEditingController textEditingController;

  @override
  TalkState clone() {
    return TalkState()
      ..id = id
      ..comments = comments
      ..hotComments = hotComments
      ..page = page
      ..textEditingController = textEditingController
      ..showLoading = showLoading;
  }
}

TalkState initState(Map<String, dynamic> args) {
  var talkState = TalkState();
  talkState.id = args['id'];
  talkState.hotComments = List();
  talkState.comments = List();
  talkState.showLoading = true;
  talkState.page = 0;
  talkState.textEditingController = TextEditingController();
  return talkState;
}
