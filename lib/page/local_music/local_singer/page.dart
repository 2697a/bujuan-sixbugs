import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LocalSingerPage extends Page<LocalSingerState, Map<String, dynamic>> {
  LocalSingerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LocalSingerState>(
                adapter: null,
                slots: <String, Dependent<LocalSingerState>>{
                }),
            middleware: <Middleware<LocalSingerState>>[
            ],);

}
