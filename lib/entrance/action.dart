import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:fish_redux/fish_redux.dart';

enum EntranceAction {
  bottomBarTap,
  pageChange,
  navBarSwitch,
  miniNavBarSwitch,
  changePlayState,
  changeCurrSong,
  openPlayPage,
  sendTask,
  nextSong,
  openPage,
}

class EntranceActionCreator {
  static Action onBottomBarTap(selectIndex) {
    return Action(EntranceAction.bottomBarTap, payload: selectIndex);
  }

  static Action onPageChange(index) {
    return Action(EntranceAction.pageChange, payload: index);
  }

  static Action onNavBarSwitch() {
    return Action(EntranceAction.navBarSwitch);
  }
  static Action onMiniNavBarSwitch() {
    return Action(EntranceAction.miniNavBarSwitch);
  }
  static Action changePlayState(PlayStateType state) {
    return Action(EntranceAction.changePlayState, payload: state);
  }

  static Action changeCurrSong(String state) {
    return Action(EntranceAction.changeCurrSong, payload: state);
  }

  static Action openPlayPage() {
    return Action(EntranceAction.openPlayPage);
  }
  static Action openPage(OpenType openType) {
    return Action(EntranceAction.openPage,payload: openType);
  }
  static Action sendTask() {
    return Action(EntranceAction.sendTask);
  }
  static Action nextSong() {
    return Action(EntranceAction.nextSong);
  }
}
