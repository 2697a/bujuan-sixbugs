import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayBarPage extends Page<PlayBarState, Map<String, dynamic>> {
  PlayBarPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlayBarState>(
              adapter: null, slots: <String, Dependent<PlayBarState>>{}),
          middleware: <Middleware<PlayBarState>>[],
        )
  {
    this.connectExtraStore<GlobalState>(GlobalStore.store,
        (Object pageState, GlobalState appState) {
      final GlobalBaseState p = pageState;
      if (p.playStateType != null &&
          p.playStateType == appState.playStateType &&
          p.currSong != null &&
          p.currSong == appState.currSong) {
        return pageState;
      } else {
        if (pageState is Cloneable) {
          final Object copy = pageState.clone();
          final GlobalBaseState newState = copy;
          newState.playStateType = appState.playStateType;
          newState.currSong = appState.currSong;
          return newState;
        }
        return pageState;
      }
    });
  }
}
