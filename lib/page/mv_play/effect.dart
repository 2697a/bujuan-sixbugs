import 'package:bujuan/bujuan_music.dart';
import 'package:bujuan/entity/mv_player_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import 'package:bujuan/api/module.dart';

Effect<MvPlayViewState> buildEffect() {
  return combineEffects(<Object, Effect<MvPlayViewState>>{
    MvPlayViewAction.action: _onAction,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose
  });
}

void _onAction(Action action, Context<MvPlayViewState> ctx) {}

void _init(Action action, Context<MvPlayViewState> ctx) async{
 await _getMvDetals(ctx.state.mvId).then((mv) {
    BujuanMusic.control(task: 'pause');
    if (mv != null) {
      ctx.dispatch(MvPlayViewActionCreator.getMvData(mv));
    }
  });
}

void _dispose(Action action, Context<MvPlayViewState> ctx) {
//  ctx.state.player?.release();
}

Future<MvPlayerEntity> _getMvDetals(mvId) async {
  var answer = await mv_detail({'mvid': mvId},await BuJuanUtil.getCookie());
  return answer.status == 200 ? MvPlayerEntity.fromJson(answer.body) : null;
}
