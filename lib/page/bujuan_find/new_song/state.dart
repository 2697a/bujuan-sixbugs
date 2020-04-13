import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class NewSongState implements Cloneable<NewSongState> {

  List<SongBeanEntity> result;
  @override
  NewSongState clone() {
    return NewSongState()..result = result;
  }
}

NewSongState initState(Map<String, dynamic> args) {
  var newSongState = NewSongState();
  return newSongState;
}
