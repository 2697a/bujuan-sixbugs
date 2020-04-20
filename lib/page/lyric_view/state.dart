import 'package:fish_redux/fish_redux.dart';

class playListState implements Cloneable<playListState> {

  @override
  playListState clone() {
    return playListState();
  }
}

playListState initState(Map<String, dynamic> args) {
  return playListState();
}
