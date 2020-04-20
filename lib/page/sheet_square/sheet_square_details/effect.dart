import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/highquality_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SheetSquareDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<SheetSquareDetailsState>>{
    Lifecycle.initState: _init,
    SheetSquareDetailsAction.loadNextTalk: _init,
  });
}

void _onAction(Action action, Context<SheetSquareDetailsState> ctx) {}

void _init(Action action, Context<SheetSquareDetailsState> ctx) async {
  var data = await _getSheet(ctx.state.type, ctx.state.page);
  if (data != null) {
    if (data.more) {
      ctx.dispatch(SheetSquareDetailsActionCreator.onGetList(data.playlists));
      ctx.dispatch(SheetSquareDetailsActionCreator.changePage(ctx.state.page + 1));
    }
  }
}

Future<HighqualityEntity> _getSheet(type, page) async {
  var answer = await top_playlist({
    'cat': type,
    'offset': page * 15,
  },await BuJuanUtil.getCookie());
  return answer.status == 200 ? HighqualityEntity.fromJson(answer.body) : null;
}
