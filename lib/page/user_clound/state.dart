import 'package:fish_redux/fish_redux.dart';

class CloundPageState implements Cloneable<CloundPageState> {

  @override
  CloundPageState clone() {
    return CloundPageState();
  }
}

CloundPageState initState(Map<String, dynamic> args) {
  return CloundPageState();
}
