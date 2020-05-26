import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:fish_redux/fish_redux.dart';

enum EntranceAction {
  bottomBarTap,
  pageChange,
  miniNavBarSwitch,
  openPage,
  changeDar,
  changeUpdate,
  changeBack
}

class EntranceActionCreator {
  static Action onBottomBarTap(selectIndex) {
    return Action(EntranceAction.bottomBarTap, payload: selectIndex);
  }

  //pageView页面切换
  static Action onPageChange(index) {
    return Action(EntranceAction.pageChange, payload: index);
  }

  //迷你导航栏
  static Action onMiniNavBarSwitch() {
    return Action(EntranceAction.miniNavBarSwitch);
  }
  //迷你导航栏
  static Action onBlack() {
    return Action(EntranceAction.changeBack);
  }
  //底栏是否可滑动
  static Action onChangeDar(bool isDar) {
    return Action(EntranceAction.changeDar,payload: isDar);
  }
  //打开其他页面
  static Action openPage(OpenType openType) {
    return Action(EntranceAction.openPage, payload: openType);
  }

  static Action onUpdate() {
    return Action(EntranceAction.changeUpdate);
  }
}
