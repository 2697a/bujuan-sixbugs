import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HotSingerPage extends Page<HotSingerState, Map<String, dynamic>> {
  HotSingerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HotSingerState>(
                adapter: null,
                slots: <String, Dependent<HotSingerState>>{
                }),
            middleware: <Middleware<HotSingerState>>[
            ],);

}
