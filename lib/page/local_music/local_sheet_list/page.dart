import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LocalSheetListPage extends Page<LocalSheetListState, Map<String, dynamic>> {
  LocalSheetListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LocalSheetListState>(
                adapter: null,
                slots: <String, Dependent<LocalSheetListState>>{
                }),
            middleware: <Middleware<LocalSheetListState>>[
            ],);

}
