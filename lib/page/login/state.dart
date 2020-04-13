import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class LoginState implements Cloneable<LoginState> {

  TextEditingController phone= TextEditingController();
  TextEditingController pass= TextEditingController();
  @override
  LoginState clone() {
    return LoginState()..phone=phone..pass=pass;
  }
}

LoginState initState(Map<String, dynamic> args) {
  final LoginState loginState = LoginState();
  return loginState;
}
