import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewSongComponent extends Component<NewSongState> {
  NewSongComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NewSongState>(
                adapter: null,
                slots: <String, Dependent<NewSongState>>{
                }),);

}
