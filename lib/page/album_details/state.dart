import 'package:fish_redux/fish_redux.dart';

class AlbumDetailsState implements Cloneable<AlbumDetailsState> {

  @override
  AlbumDetailsState clone() {
    return AlbumDetailsState();
  }
}

AlbumDetailsState initState(Map<String, dynamic> args) {
  return AlbumDetailsState();
}
