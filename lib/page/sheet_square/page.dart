import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SheetSquarePage extends Page<SheetSquareState, Map<String, dynamic>> {
  SheetSquarePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SheetSquareState>(
                adapter: null,
                slots: <String, Dependent<SheetSquareState>>{
                }),
            middleware: <Middleware<SheetSquareState>>[
            ],);

}
