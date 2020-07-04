import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';

//TODO replace with your own action
enum PlayBarAction {
  action,
  changePlayState,
  changeCurrSong,
  openPlayPage,
  sendTask,
  nextSong
}

class PlayBarActionCreator {
  static Action onAction() {
    return const Action(PlayBarAction.action);
  }

  static Action changePlayState(PlayState state) {
    return Action(PlayBarAction.changePlayState, payload: state);
  }

  static Action changeCurrSong(String state) {
    return Action(PlayBarAction.changeCurrSong, payload: state);
  }

  static Action openPlayPage() {
    return Action(PlayBarAction.openPlayPage);
  }

  static Action sendTask() {
    return Action(PlayBarAction.sendTask);
  }
  static Action nextSong() {
    return Action(PlayBarAction.nextSong);
  }
}
