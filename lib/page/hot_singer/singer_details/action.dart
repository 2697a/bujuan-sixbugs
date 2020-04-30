import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SingerDetailsAction { getSingerBean,getSingerSongs,playSong ,getSingerAlbum}

class SingerDetailsActionCreator {
  static Action onSingerBean(bean) {
    return  Action(SingerDetailsAction.getSingerBean,payload: bean);
  }

  static Action onSingerSongs(songs) {
    return  Action(SingerDetailsAction.getSingerSongs,payload: songs);
  }
  static Action ongetSingerAlbum(album) {
    return  Action(SingerDetailsAction.getSingerAlbum,payload: album);
  }
  static Action onPlaySong(index) {
    return  Action(SingerDetailsAction.playSong,payload: index);
  }
}
