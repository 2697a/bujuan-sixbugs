
import 'package:bujuan/utils/net_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchSongState> buildEffect() {
  return combineEffects(<Object, Effect<SearchSongState>>{
    SearchSongAction.playSong: _playSong,
  });
}

void _playSong(Action action, Context<SearchSongState> ctx) {
//  SpUtil.putBool(ISFM, false);
//  var index2 = action.payload;
////  GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(ctx.state.songs[index2]));
//  SpUtil.putObjectList(playSongListHistory, ctx.state.songs);
//  var jsonEncode2 = jsonEncode(ctx.state.songs);
//  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
  var list = ctx.state.songs;
  var index = action.payload??0;
  NetUtils().setPlayListAndPlayById(list, index, '${DateTime.now().toIso8601String()}');
}
