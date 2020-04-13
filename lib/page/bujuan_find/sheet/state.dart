import 'package:bujuan/entity/personal_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SheetViewState implements Cloneable<SheetViewState> {
  List<PersonalResult> result;
  @override
  SheetViewState clone() {
    return SheetViewState()..result = result;
  }
}

SheetViewState initState(Map<String, dynamic> args) {
  var sheetViewState = SheetViewState();
  return sheetViewState;
}
