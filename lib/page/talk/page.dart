import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TalkPage extends Page<TalkState, Map<String, dynamic>> {
  TalkPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TalkState>(
                adapter: null,
                slots: <String, Dependent<TalkState>>{
                }),
            middleware: <Middleware<TalkState>>[
            ],);

}
