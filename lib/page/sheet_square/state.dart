import 'package:fish_redux/fish_redux.dart';

class SheetSquareState implements Cloneable<SheetSquareState> {

  @override
  SheetSquareState clone() {
    return SheetSquareState();
  }
}

SheetSquareState initState(Map<String, dynamic> args) {
  return SheetSquareState();
}
