import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EntrancePage extends Page<EntranceState, Map<String, dynamic>> with SingleTickerProviderMixin {
  EntrancePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<EntranceState>(
                adapter: null,
                slots: <String, Dependent<EntranceState>>{
                }),
            middleware: <Middleware<EntranceState>>[
            ],);


}
