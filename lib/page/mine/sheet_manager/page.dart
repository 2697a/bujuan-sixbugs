import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SheetManagerPage extends Page<SheetManagerState, Map<String, dynamic>> {
  SheetManagerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SheetManagerState>(
                adapter: null,
                slots: <String, Dependent<SheetManagerState>>{
                }),
            middleware: <Middleware<SheetManagerState>>[
            ],);

}
