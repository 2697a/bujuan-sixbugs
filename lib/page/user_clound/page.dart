import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CloundPagePage extends Page<CloundPageState, Map<String, dynamic>> {
  CloundPagePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CloundPageState>(
                adapter: null,
                slots: <String, Dependent<CloundPageState>>{
                }),
            middleware: <Middleware<CloundPageState>>[
            ],);

}
