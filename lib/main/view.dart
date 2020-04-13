import 'package:bujuan/main/routes.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../android_back_desktop.dart';
import '../constant/theme.dart';
import 'state.dart';

Widget buildView(MainState state, Dispatch dispatch, ViewService viewService) {
  return MaterialApp(
    title: '不倦',
//    showPerformanceOverlay: true, // 开启
    debugShowCheckedModeBanner: false,
    color: Colors.blue,
    theme: state.appTheme.dark ? darkTheme : lightTheme,
    home: WillPopScope(child: routes.buildPage('entrance_page', null), onWillPop: () async {
      AndroidBackTop.backDeskTop(); //设置为返回不退出app
      return false;
    }),
    routes: appRoutes,
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
