import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MvPage extends Page<MvState, Map<String, dynamic>> {
  MvPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MvState>(
                adapter: null,
                slots: <String, Dependent<MvState>>{
                }),
            middleware: <Middleware<MvState>>[
            ],);

}
