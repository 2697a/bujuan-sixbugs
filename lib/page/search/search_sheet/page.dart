import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchSheetPage extends Page<SearchSheetState, Map<String, dynamic>> {
  SearchSheetPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchSheetState>(
                adapter: null,
                slots: <String, Dependent<SearchSheetState>>{
                }),
            middleware: <Middleware<SearchSheetState>>[
            ],);

}
