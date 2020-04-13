import 'package:bujuan/entity/mv_player_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MvPlayViewAction { action,getMvData }

class MvPlayViewActionCreator {
  static Action onAction() {
    return const Action(MvPlayViewAction.action);
  }

  static Action getMvData(MvPlayerEntity mvPlayerEntity) {
    return  Action(MvPlayViewAction.getMvData,payload: mvPlayerEntity);
  }
}
