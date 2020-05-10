import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/play_history_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<HistoryState> buildEffect() {
  return combineEffects(<Object, Effect<HistoryState>>{
    Lifecycle.initState: _init,
    HistoryAction.playSong: _playSong
  });
}

void _init(Action action, Context<HistoryState> ctx) {
  _getHistory(SpUtil.getInt(USER_ID, defValue: 0)).then((history) {
    if (history != null) {
      List<SongBeanEntity> newList = List();
      history.allData.forEach((details) {
        var singerStr = '';
        var ar = details.song.ar;
        ar.forEach((singer) {
          singerStr += ' ${singer.name} ';
        });
        SongBeanEntity songBeanEntity = SongBeanEntity(
            name: details.song.name,
            id: details.song.id.toString(),
            picUrl: details.song.al.picUrl,
            singer: singerStr,
            mv: details.song.mv);
        newList.add(songBeanEntity);
      });
      ctx.dispatch(HistoryActionCreator.getHistoryData(newList));
    }
  });
}

void _playSong(Action action, Context<HistoryState> ctx) {
  SpUtil.putBool(ISFM, false);
  var index2 = action.payload;
  GlobalStore.store
      .dispatch(GlobalActionCreator.changeCurrSong(ctx.state.list[index2]));
  SpUtil.putObjectList(playSongListHistory, ctx.state.list);
  var jsonEncode2 = jsonEncode(ctx.state.list);
  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}

Future<PlayHistoryEntity> _getHistory(id) async {
  var answer = await user_record({'uid': id},await BuJuanUtil.getCookie());
  return answer.status == 200 ? PlayHistoryEntity.fromJson(answer.body) : null;
}
