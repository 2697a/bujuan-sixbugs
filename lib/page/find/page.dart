import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FindPage extends Page<FindState, Map<String, dynamic>> {
  FindPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FindState>(
                adapter: null,
                slots: <String, Dependent<FindState>>{
                }),
            middleware: <Middleware<FindState>>[
            ],);

}
