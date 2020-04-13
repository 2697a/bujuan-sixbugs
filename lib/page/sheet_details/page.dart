import 'package:fish_redux/fish_redux.dart';

import 'adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SheetDetailsPage extends Page<SheetDetailsState, Map<String, dynamic>> {
  SheetDetailsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SheetDetailsState>(
                adapter:  null,
                slots: <String, Dependent<SheetDetailsState>>{
                }),
            middleware: <Middleware<SheetDetailsState>>[
            ],);

}
