import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TalkState> buildReducer() {
  return asReducer(
    <Object, Reducer<TalkState>>{
      TalkAction.getTalk: _onGetTalk,
      TalkAction.getHotTalk: _onGetHotTalk,
      TalkAction.talkPage: _onTalkPage
    },
  );
}

TalkState _onGetTalk(TalkState state, Action action) {
  final TalkState newState = state.clone();
  newState.comments??[]..addAll(action.payload);
  newState.showLoading = false;
  return newState;
}

TalkState _onGetHotTalk(TalkState state, Action action) {
  final TalkState newState = state.clone();
  newState.hotComments??[]..addAll(action.payload);
  return newState;
}

TalkState _onTalkPage(TalkState state, Action action) {
  final TalkState newState = state.clone();
  newState.page = action.payload;
  return newState;
}