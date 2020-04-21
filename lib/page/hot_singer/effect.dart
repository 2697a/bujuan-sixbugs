import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/singer_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<HotSingerState> buildEffect() {
  return combineEffects(<Object, Effect<HotSingerState>>{
    Lifecycle.initState: _init,
    HotSingerAction.onLoad: _init,
  });
}

void _init(Action action, Context<HotSingerState> ctx) async {
  var singerEntity = await _getHotSinger(ctx.state.page);
  if (singerEntity != null) {
    if (singerEntity.more) ctx.dispatch(HotSingerActionCreator.getSinger(singerEntity.artists));
  }
}

Future<SingerEntity> _getHotSinger(page) async {
  var answer = await top_artists({'offset': page * 15},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SingerEntity.fromJson(answer.body) : null;
}
