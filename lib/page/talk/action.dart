import 'package:bujuan/entity/song_talk_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TalkAction { getTalk, getHotTalk, talkPage, loadNextTalk, sendTalk }

class TalkActionCreator {
//  List<SongTalkCommants> comments;
//  List<SongTalkHotcommants> hotComments;
  static Action onGetTalk(List<SongTalkCommants> comments) {
    return Action(TalkAction.getTalk, payload: comments);
  }

  static Action onGetHotTalk(List<SongTalkHotcommants> hotComments) {
    return Action(TalkAction.getHotTalk, payload: hotComments);
  }

  static Action talkPage(int page) {
    return Action(TalkAction.talkPage, payload: page);
  }

  static Action loadNextTalk() {
    return Action(TalkAction.loadNextTalk);
  }

  static Action sendTalk() {
    return Action(TalkAction.sendTalk);
  }
}
