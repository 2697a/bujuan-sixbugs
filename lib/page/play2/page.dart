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
      if (p.playState != null &&
          p.playState == appState.playState &&
          p.currSong != null &&
          p.currSong == appState.currSong &&
          p.currSongPos == appState.currSongPos &&
          p.playModeType != null &&
          p.playModeType == appState.playModeType) {
        return pageState;
      } else {
        if (pageState is Cloneable) {
          final Object copy = pageState.clone();
          final GlobalBaseState newState = copy;
          newState.playState = appState.playState;
          newState.currSong = appState.currSong;
          newState.currSongPos = appState.currSongPos;
          newState.playModeType = appState.playModeType;
          return newState;
        }
        return pageState;
      }
    });
  }
}
