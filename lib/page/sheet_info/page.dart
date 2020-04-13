import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SheetInfoPage extends Page<SheetInfoState, Map<String, dynamic>> {
  SheetInfoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SheetInfoState>(
                adapter: null,
                slots: <String, Dependent<SheetInfoState>>{
                }),
            middleware: <Middleware<SheetInfoState>>[
            ],);

}
