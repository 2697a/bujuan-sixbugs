import 'package:bujuan/entrance/page.dart';
import 'package:bujuan/main/page.dart';
import 'package:bujuan/page/about/page.dart';
import 'package:bujuan/page/donation/page.dart';
import 'package:bujuan/page/hot_singer/page.dart';
import 'package:bujuan/page/hot_singer/singer_details/page.dart';
import 'package:bujuan/page/local_music/local_list/page.dart';
import 'package:bujuan/page/local_music/page.dart';
import 'package:bujuan/page/login/page.dart';
import 'package:bujuan/page/mine/history/page.dart';
import 'package:bujuan/page/mv_play/page.dart';
import 'package:bujuan/page/play/page.dart';
import 'package:bujuan/page/radio/page.dart';
import 'package:bujuan/page/search/page.dart';
import 'package:bujuan/page/search/search_details/page.dart';
import 'package:bujuan/page/setting/setting.dart';
//import 'package:bujuan/page/setting/page.dart';
import 'package:bujuan/page/sheet_details/page.dart';
import 'package:bujuan/page/sheet_info/page.dart';
import 'package:bujuan/page/sheet_square/page.dart';
import 'package:bujuan/page/talk/page.dart';
import 'package:bujuan/page/today/page.dart';
import 'package:bujuan/page/top/top_details/page.dart';
import 'package:bujuan/page/user_clound/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action,Page;
import 'package:flutter/widgets.dart' hide Action,Page;

import '../global_store/state.dart';
import '../global_store/store.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/entrance': (BuildContext context) => routes.buildPage("entrance_page", null),
  '/main': (BuildContext context) => routes.buildPage("main", null),
};
var routes = new PageRoutes(
  pages: <String, Page<Object, dynamic>>{
    'entrance_page': EntrancePage(),
    'main': MainPage(), //电台详情页
    'sheet_details': SheetDetailsPage(),
    'play_view': PlayViewPage(),
    'login': LoginPage(),
    'today': TodayPage(),
    'sheet_info': SheetInfoPage(),
    'local': LocalMusicPage(),
    'top_details': TopDetailsPage(),
    'talk': TalkPage(),
    'mv_play': MvPlayViewPage(),
    'history': HistoryPage(),
//    'setting': SettingPage(),
    'donation': DonationPage(),
    'about': AboutPage(),
    'search': SearchPage(),
    'search_details': SearchDetailsPage(),
    'sheet_square': SheetSquarePage(),
    'hot_singer': HotSingerPage(),
    'local_list': LocalListPage(),
    'local_music': LocalMusicPage(),
    'singer_details': SingerDetailsPage(),
    'user_clound': CloundPagePage(),
    'radio': RadioPage(),
  },
  visitor: (String path, Page<Object, dynamic> page) {
    if (page.isTypeof<GlobalBaseState>()) {
      print('path=======================$page');
      page.connectExtraStore<GlobalState>(GlobalStore.store,
          (Object pageState, GlobalState appState) {
        final GlobalBaseState p = pageState;
        if (p.appTheme != null && p.appTheme.dark == appState.appTheme.dark &&p.backPath!=null&&p.backPath == appState.backPath&&p.blur!=null&&p.blur == appState.blur) {
          return pageState;
        } else {
          if (pageState is Cloneable) {
            final Object copy = pageState.clone();
            final GlobalBaseState newState = copy;
            newState.appTheme = appState.appTheme;
            newState.backPath = appState.backPath;
            newState.blur = appState.blur;
            return newState;
          }
          return pageState;
        }
      });
    }

    page.enhancer.append(
      viewMiddleware: <ViewMiddleware<dynamic>>[safetyView<dynamic>()],
      adapterMiddleware: <AdapterMiddleware<dynamic>>[safetyAdapter<dynamic>()],
      effectMiddleware: [_pageAnalyticsMiddleware()],
      middleware: <Middleware<dynamic>>[logMiddleware<dynamic>()],
    );
  },
);

/// 简单的Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}

Future appPushRoute(String path, BuildContext context, {Map<String, dynamic> params}) async {
  return await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => routes.buildPage(path, params)));
}

Future appPushRemoveRoute(String path, BuildContext context, {Map<String, dynamic> params}) async {
  return await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => routes.buildPage(path, params)), ModalRoute.withName(path));
}

Future appPushNameRoute(String path, BuildContext context) async {
  return await Navigator.of(context).pushNamed(path);
}
