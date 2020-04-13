import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SheetSquareDetailsPage extends Page<SheetSquareDetailsState, Map<String, dynamic>> with KeepAliveMixin{
  SheetSquareDetailsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SheetSquareDetailsState>(
                adapter: null,
                slots: <String, Dependent<SheetSquareDetailsState>>{
                }),
            middleware: <Middleware<SheetSquareDetailsState>>[
            ],);

}
