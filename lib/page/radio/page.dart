import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RadioPage extends Page<RadioState, Map<String, dynamic>> {
  RadioPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<RadioState>(
                adapter: null,
                slots: <String, Dependent<RadioState>>{
                }),
            middleware: <Middleware<RadioState>>[
            ],);

}
