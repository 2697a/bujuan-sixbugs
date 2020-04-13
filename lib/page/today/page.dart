import 'package:fish_redux/fish_redux.dart';

import 'adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TodayPage extends Page<TodayState, Map<String, dynamic>> {
  TodayPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TodayState>(
//                adapter:  NoneConn<TodayState>() + TodayAdapterAdapter(),
                adapter:  null,
                slots: <String, Dependent<TodayState>>{
                }),
            middleware: <Middleware<TodayState>>[
            ],);

}
