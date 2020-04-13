import 'package:bujuan/entity/search_mv_entity.dart';
import 'package:bujuan/entity/search_sheet_entity.dart';
import 'package:bujuan/entity/search_singer_entity.dart';
import 'package:bujuan/entity/search_song_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchDetailsAction { getSong, getMv, getSinger, getSheet }

class SearchDetailsActionCreator {
  static Action getSong(List<SongBeanEntity> songs) {
    return Action(SearchDetailsAction.getSong, payload: songs);
  }

  static Action getSheet(List<SearchSheetResultPlaylist> playlists) {
    return Action(SearchDetailsAction.getSheet, payload: playlists);
  }

  static Action getSinger(List<SearchSingerResultArtist> artists) {
    return Action(SearchDetailsAction.getSinger, payload: artists);
  }

  static Action getMv(List<SearchMvResultMv> mvs) {
    return Action(SearchDetailsAction.getMv, payload: mvs);
  }
}
