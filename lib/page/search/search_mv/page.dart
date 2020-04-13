import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchMvPage extends Page<SearchMvState, Map<String, dynamic>> {
  SearchMvPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchMvState>(
                adapter: null,
                slots: <String, Dependent<SearchMvState>>{
                }),
            middleware: <Middleware<SearchMvState>>[
            ],);

}
