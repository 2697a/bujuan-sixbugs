import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TopDetailsPage extends Page<TopDetailsState, Map<String, dynamic>> {
  TopDetailsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TopDetailsState>(
                adapter: null,
                slots: <String, Dependent<TopDetailsState>>{
                }),
            middleware: <Middleware<TopDetailsState>>[
            ],);

}
