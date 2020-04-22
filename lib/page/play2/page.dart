import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayView2Page extends Page<PlayView2State, Map<String, dynamic>>
    with TickerProviderMixin<PlayView2State> {
  PlayView2Page()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlayView2State>(
              adapter: null, slots: <String, Dependent<PlayView2State>>{}),
          middleware: <Middleware<PlayView2State>>[],
        )
  {
    this.connectExtraStore<GlobalState>(GlobalStore.store,
        (Object pageState, GlobalState appState) {
      final GlobalBaseState p = pageState;
      if (p.playStateType != null &&
          p.playStateType == appState.playStateType &&
          p.currSong != null &&
          p.currSong == appState.currSong &&
          p.currSongPos == appState.currSongPos &&
          p.currSongAllPos == appState.currSongAllPos &&
          p.playModeType != null &&
          p.playModeType == appState.playModeType) {
        return pageState;
      } else {
        if (pageState is Cloneable) {
          final Object copy = pageState.clone();
          final GlobalBaseState newState = copy;
          newState.playStateType = appState.playStateType;
          newState.currSong = appState.currSong;
          newState.currSongPos = appState.currSongPos;
          newState.currSongAllPos = appState.currSongAllPos;
          newState.playModeType = appState.playModeType;
          return newState;
        }
        return pageState;
      }
    });
  }
}
