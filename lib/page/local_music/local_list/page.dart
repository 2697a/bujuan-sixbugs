import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LocalListPage extends Page<LocalListState, Map<String, dynamic>> {
  LocalListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LocalListState>(
                adapter: null,
                slots: <String, Dependent<LocalListState>>{
                }),
            middleware: <Middleware<LocalListState>>[
            ],);

}
