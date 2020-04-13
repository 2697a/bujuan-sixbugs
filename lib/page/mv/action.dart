import 'package:bujuan/page/mv/view.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MvAction { changeTag }

class MvActionCreator {
  static Action onChangeTag(MvTag mvTag) {
    return  Action(MvAction.changeTag,payload: mvTag);
  }
}
