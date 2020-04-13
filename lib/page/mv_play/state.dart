import 'package:bujuan/entity/mv_player_entity.dart';
//import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';

class MvPlayViewState implements Cloneable<MvPlayViewState> {
//  FijkPlayer player;

  MvPlayerEntity mvData;
  int mvId;
  bool showLoading;

  @override
  MvPlayViewState clone() {
    return MvPlayViewState()
//      ..player = player
      ..mvData = mvData
      ..mvId = mvId
      ..showLoading = showLoading;
  }
}

MvPlayViewState initState(Map<String, dynamic> args) {
  var mvPlayViewState = MvPlayViewState();
//  mvPlayViewState.player = FijkPlayer();
  mvPlayViewState.mvId = args['mvId'];
  mvPlayViewState.showLoading = true;
  return mvPlayViewState;
}
