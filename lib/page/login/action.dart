import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LoginAction { onLogin }

class LoginActionCreator {
  static Action onLogin(user, pass) {
    return Action(LoginAction.onLogin, payload: {'phone': user, 'password': pass});
  }
}
