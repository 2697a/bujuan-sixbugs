import 'package:bujuan/global_store/state.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayViewPage extends Page<PlayViewState, Map<String, dynamic>>
    with TickerProviderMixin<PlayViewState> {
  PlayViewPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PlayViewState>(
              adapter: null, slots: <String, Dependent<PlayViewState>>{}),
          middleware: <Middleware<PlayViewState>>[],
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
          p.currSongAllPos == appState.currSongAllPos &&
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
          newState.currSongAllPos = appState.currSongAllPos;
          newState.playModeType = appState.playModeType;
          return newState;
        }
        return pageState;
      }
    });
  }
}
