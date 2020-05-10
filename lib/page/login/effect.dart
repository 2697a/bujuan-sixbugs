import 'dart:io';

import 'package:bujuan/api/answer.dart';
import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/login_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:path_provider/path_provider.dart';
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
        SpUtil.putInt(USER_ID, login.account.id);
        SpUtil.putString('head', login.profile.avatarUrl);
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
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cookie=new PersistCookieJar(dir:tempPath,ignoreExpires: true);
    cookie.saveFromResponse(Uri.parse("https://music.163.com/weapi/"), loginData.cookie);
    return LoginEntity.fromJson(loginData.body);
  }
  return null;
}