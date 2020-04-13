import 'package:bujuan/page/mv/view.dart';
import 'package:fish_redux/fish_redux.dart';

class MvState implements Cloneable<MvState> {

  MvTag tag;
  @override
  MvState clone() {
    return MvState()..tag = tag;
  }
}

MvState initState(Map<String, dynamic> args) {
  var mvState = MvState();
  mvState.tag = MvTag.TJ;
  return mvState;
}
