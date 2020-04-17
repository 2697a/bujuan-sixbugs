import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/main/reducer.dart';
import 'package:bujuan/main/state.dart';
import 'package:bujuan/main/view.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';

class MainPage extends Page<MainState, Map<String, dynamic>> {
  MainPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
//          wrapper: keepAliveWrapper,
          dependencies: Dependencies<MainState>(
              adapter: null, slots: <String, Dependent<MainState>>{}),
          middleware: <Middleware<MainState>>[],
        ){
    this.connectExtraStore<GlobalState>(GlobalStore.store,
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
}
