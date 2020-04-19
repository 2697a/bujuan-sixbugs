import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingerDetailsPage extends Page<SingerDetailsState, Map<String, dynamic>> {
  SingerDetailsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SingerDetailsState>(
                adapter: null,
                slots: <String, Dependent<SingerDetailsState>>{
                }),
            middleware: <Middleware<SingerDetailsState>>[
            ],);

}
