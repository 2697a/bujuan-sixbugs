import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SheetManagerAction { del,edit,sub,subState,select,delState }

class SheetManagerActionCreator {
  static Action onDel(index) {
    return  Action(SheetManagerAction.del,payload: index);
  }

  static Action onEdit(id,index) {
    return  Action(SheetManagerAction.edit,payload: index);
  }

  static Action onSub(index) {
    return  Action(SheetManagerAction.sub,payload: index);
  }

  static Action onSubState(index) {
    return  Action(SheetManagerAction.subState,payload: index);
  }

  static Action onDelState(index) {
    return  Action(SheetManagerAction.delState,payload: index);
  }
  static Action onSelect(id) {
    return  Action(SheetManagerAction.select,payload: id);
  }
}
