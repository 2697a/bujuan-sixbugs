import 'package:bujuan/entity/local_sheet.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LocalSheetListAction { action, changList, del }

class LocalSheetListActionCreator {
  static Action onAction() {
    return Action(LocalSheetListAction.action);
  }

  static Action changList(List<LocalSheetEntity> list) {
    return Action(LocalSheetListAction.changList, payload: list);
  }

  static Action del(id) {
    return Action(LocalSheetListAction.del, payload: id);
  }
}
