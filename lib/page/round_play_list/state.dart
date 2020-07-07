import 'package:fish_redux/fish_redux.dart';

class RoundPlayState implements Cloneable<RoundPlayState> {

  @override
  RoundPlayState clone() {
    return RoundPlayState();
  }
}

RoundPlayState initState(Map<String, dynamic> args) {
  return RoundPlayState();
}
