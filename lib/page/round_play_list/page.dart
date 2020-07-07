import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RoundPlayPage extends Page<RoundPlayState, Map<String, dynamic>> {
  RoundPlayPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<RoundPlayState>(
                adapter: null,
                slots: <String, Dependent<RoundPlayState>>{
                }),
            middleware: <Middleware<RoundPlayState>>[
            ],);

}
