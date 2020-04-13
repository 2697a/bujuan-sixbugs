import 'package:bujuan/api/answer.dart';
import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/login_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginAction.onLogin: _onLogin,
    Lifecycle.dispose: _onDispose
  });
}

void _onLogin(Action action, Context<LoginState> ctx) {
  var loginInfo = action.payload;
  var phone = loginInfo['phone'];
  var pass = loginInfo['password'];
  if (phone != '' && pass != '') {
    _loginByPhone(phone, pass).then((login) {
      Navigator.pop(ctx.context);
      if (login != null) {
        FocusScope.of(ctx.context).requestFocus(FocusNode());
        SpUtil.putInt(Constants.USER_ID, login.account.id);
        Navigator.pop(ctx.context, login);
      } else {
        BuJuanUtil.showToast('登陆失败，请重试！');
      }
    });
  } else {
    Navigator.pop(ctx.context);
    BuJuanUtil.showToast('账号密码不能为空！');
  }
}

void _onDispose(Action action, Context<LoginState> ctx) {
  ctx.state.phone?.dispose();
  ctx.state.pass?.dispose();
}

Future<LoginEntity> _loginByPhone(phone, pass) async {
  Answer loginData;
  if (BuJuanUtil.isEmail(phone)) {
    loginData = await login({'email': phone, 'password': pass}, new List());
  } else {
    loginData =
        await login_cellphone({'phone': phone, 'password': pass}, new List());
  }
  if (loginData.status == 200) {
    BuJuanUtil.saveCookie(loginData.cookie);
    return LoginEntity.fromJson(loginData.body);
  }
  return null;
}
//Future<LoginEntity> _loginByPhone(loginInfo) async {
//  var phone = loginInfo['phone'];
//  var pass = loginInfo['password'];
//  var loginEntity;
//  if (phone != '' && pass != '') {
//    var httpClient = new HttpClient();
//    var uri;
//    if (BuJuanUtil.isEmail(phone)) {
//      uri = new Uri.http(
//          '127.0.0.1:3001', '/login', {'email': phone, 'password': pass});
//    } else {
//      uri = new Uri.http('127.0.0.1:3001', '/login/cellphone',
//          {'phone': phone, 'password': pass});
//    }
//    var request = await httpClient.getUrl(uri);
//    var response = await request.close();
//    if (response.statusCode == 200) {
//      String cookie = "";
//      var responseBody = await response.transform(utf8.decoder).join();
//      response.cookies.forEach((f) => cookie += f.toString() + ";");
//      SpUtil.putString(
//          Constants.COOKIE, cookie.substring(0, cookie.length - 1));
//      Map<String, dynamic> json = jsonDecode(responseBody);
//      loginEntity = LoginEntity.fromJson(json);
//    }
//  }
//  return loginEntity;
//}
