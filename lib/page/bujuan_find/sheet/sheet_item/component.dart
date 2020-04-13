import 'package:bujuan/entity/personal_entity.dart';
import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class TopSheetComponent extends Component<PersonalResult> {
  TopSheetComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<PersonalResult>(
              adapter: null, slots: <String, Dependent<PersonalResult>>{}),
        );
}
