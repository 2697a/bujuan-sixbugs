import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AlbumDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<AlbumDetailsState>>{
    AlbumDetailsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AlbumDetailsState> ctx) {
}
