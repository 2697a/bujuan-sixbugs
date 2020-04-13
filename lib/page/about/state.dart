import 'package:fish_redux/fish_redux.dart';

class AboutState implements Cloneable<AboutState> {

  @override
  AboutState clone() {
    return AboutState();
  }
}

AboutState initState(Map<String, dynamic> args) {
  return AboutState();
}
