import 'package:bujuan/entity/singer_album.dart';
import 'package:bujuan/entity/singer_song.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class SingerDetailsState implements Cloneable<SingerDetailsState> {
  bool isShowLoading;
  String singerId;
  List<String> tabs;
  Artist artistBean;
  List<HotAlbums> albums;
  List<SongBeanEntity> songs;
  @override
  SingerDetailsState clone() {
    return SingerDetailsState()
      ..isShowLoading = isShowLoading
      ..singerId = singerId
      ..artistBean = artistBean
      ..tabs = tabs
      ..albums = albums
      ..songs = songs;
  }
}

SingerDetailsState initState(Map<String, dynamic> args) {
  var singerDetailsState = SingerDetailsState();
  var id = args['id'];
  singerDetailsState.singerId = '$id';
  singerDetailsState.isShowLoading = true;
  singerDetailsState.tabs = <String>[
    "热门单曲",
    "专辑",
    "视频",
  ];
  return singerDetailsState;
}
