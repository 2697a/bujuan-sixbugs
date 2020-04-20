import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/song_talk_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TalkState> buildEffect() {
  return combineEffects(<Object, Effect<TalkState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    TalkAction.loadNextTalk: _init,
    TalkAction.sendTalk: _send,
  });
}

void _init(Action action, Context<TalkState> ctx) async {
  var talk = await _getTalk(ctx.state.id, ctx.state.page);
  if (talk.more) {
    ctx.dispatch(TalkActionCreator.onGetTalk(talk.comments));
    ctx.dispatch(TalkActionCreator.onGetHotTalk(talk.hotComments ?? <SongTalkHotcommants>[]));
    ctx.dispatch(TalkActionCreator.talkPage(ctx.state.page + 1));
  }
}

void _dispose(Action action, Context<TalkState> ctx) async {
  ctx.state.textEditingController?.dispose();
}

void _send(Action action, Context<TalkState> ctx) async {
  var text2 = ctx.state.textEditingController.text;
  if (text2 != '')
    _sendTalk(ctx.state.id, text2).then((isSuccess) {
      if (isSuccess)
        BuJuanUtil.showToast('评论成功');
      else
        BuJuanUtil.showToast('评论失败');
    });
  ctx.state.textEditingController.text = '';
}

///comment/playlist
Future<SongTalkEntity> _getTalk(id, page) async {
  var songTalkEntity;
  var answer = await comment_music({
    'id': id,
    'offset': page * 15,
  },await BuJuanUtil.getCookie());
  if (answer.status == 200) {
    songTalkEntity = SongTalkEntity.fromJson(answer.body);
  }
  return songTalkEntity;
}

Future<bool> _sendTalk(id, content) async {
  var answer = await comment({'id': id, 't': 1, 'type': 0, 'content': content},await BuJuanUtil.getCookie());
  if (answer.status == 200) {
    return true;
  }
  return false;
}
