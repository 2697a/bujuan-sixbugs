import 'package:bujuan/main/reducer.dart';
import 'package:bujuan/main/state.dart';
import 'package:bujuan/main/view.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';

class MainPage extends Page<MainState, Map<String, dynamic>> with WidgetsBindingObserverMixin{
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
        );
}
