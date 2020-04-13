import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MinePage extends Page<MineState, Map<String, dynamic>>   with KeepAliveMixin {
  MinePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MineState>(
                adapter: null,
                slots: <String, Dependent<MineState>>{
                }),
            middleware: <Middleware<MineState>>[
            ],);

}
