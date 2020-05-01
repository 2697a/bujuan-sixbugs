import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:fish_redux/fish_redux.dart';

enum EntranceAction {
  bottomBarTap,
  pageChange,
  navBarSwitch,
  miniNavBarSwitch,
  openPage,
  changeUpdate
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

  //迷你导航栏
  static Action onMiniNavBarSwitch() {
    return Action(EntranceAction.miniNavBarSwitch);
  }

  //打开其他页面
  static Action openPage(OpenType openType) {
    return Action(EntranceAction.openPage, payload: openType);
  }

  static Action onUpdate() {
    return Action(EntranceAction.changeUpdate);
  }
}
