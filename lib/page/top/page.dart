import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TopPagePage extends Page<TopPageState, Map<String, dynamic>> with KeepAliveMixin{
  TopPagePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TopPageState>(
                adapter: null,
                slots: <String, Dependent<TopPageState>>{
                }),
            middleware: <Middleware<TopPageState>>[
            ],);

}
