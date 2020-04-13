import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewBannerComponent extends Component<NewBannerState> {
  NewBannerComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NewBannerState>(
                adapter: null,
                slots: <String, Dependent<NewBannerState>>{
                }),);

}
