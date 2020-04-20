import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class playListPage extends Page<playListState, Map<String, dynamic>> {
  playListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<playListState>(
                adapter: null,
                slots: <String, Dependent<playListState>>{
                }),
            middleware: <Middleware<playListState>>[
            ],);

}
