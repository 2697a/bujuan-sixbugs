import 'package:fish_redux/fish_redux.dart';

class RadioState implements Cloneable<RadioState> {

  @override
  RadioState clone() {
    return RadioState();
  }
}

RadioState initState(Map<String, dynamic> args) {
  return RadioState();
}
