import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MvPlayViewPage extends Page<MvPlayViewState, Map<String, dynamic>> {
  MvPlayViewPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MvPlayViewState>(
                adapter: null,
                slots: <String, Dependent<MvPlayViewState>>{
                }),
            middleware: <Middleware<MvPlayViewState>>[
            ],);

}
