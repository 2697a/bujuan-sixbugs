import 'package:bujuan/entity/singer_song.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SingerDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SingerDetailsState>>{
      SingerDetailsAction.getSingerBean: _onSingerBean,
      SingerDetailsAction.getSingerSongs: _onSingerSongs,
      SingerDetailsAction.getSingerAlbum: _onSingerAlbum
    },
  );
}

SingerDetailsState _onSingerBean(SingerDetailsState state, Action action) {
  final SingerDetailsState newState = state.clone();
  newState.artistBean = action.payload;
  return newState;
}
SingerDetailsState _onSingerAlbum(SingerDetailsState state, Action action) {
  final SingerDetailsState newState = state.clone();
  newState.albums = action.payload;
  return newState;
}
SingerDetailsState _onSingerSongs(SingerDetailsState state, Action action) {
  final SingerDetailsState newState = state.clone();
  List<SongBeanEntity> song = [];
  List<HotSongs> payload = action.payload;
  Future.forEach(payload, (HotSongs hotSong){
    SongBeanEntity songBeanEntity = SongBeanEntity();
    songBeanEntity.name = hotSong.name;
    songBeanEntity.id = '${hotSong.id}';
    songBeanEntity.picUrl = hotSong.al.picUrl;
    songBeanEntity.mv = hotSong.mv;
    songBeanEntity.singer = hotSong.ar[0].name;
    song.add(songBeanEntity);
  });
  newState.songs = song;
  return newState;
}