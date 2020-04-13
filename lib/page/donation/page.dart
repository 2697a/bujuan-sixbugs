import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DonationPage extends Page<DonationState, Map<String, dynamic>> {
  DonationPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DonationState>(
                adapter: null,
                slots: <String, Dependent<DonationState>>{
                }),
            middleware: <Middleware<DonationState>>[
            ],);

}
