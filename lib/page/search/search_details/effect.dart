import 'package:bujuan/api/module.dart';
import 'package:bujuan/entity/search_mv_entity.dart';
import 'package:bujuan/entity/search_sheet_entity.dart';
import 'package:bujuan/entity/search_singer_entity.dart';
import 'package:bujuan/entity/search_song_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/song_de_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<SearchDetailsState>>{Lifecycle.initState: _init});
}

void _init(Action action, Context<SearchDetailsState> ctx) {
  _searchSheetData(ctx.state.searchContent).then((sheet) {
    if (sheet != null) {
      ctx.dispatch(SearchDetailsActionCreator.getSheet(sheet.result.playlists));
    }
  });
  _searchSingerData(ctx.state.searchContent).then((singer) {
    if (singer != null) {
      ctx.dispatch(SearchDetailsActionCreator.getSinger(singer.result.artists));
    }
  });
  _searchMvData(ctx.state.searchContent).then((mv) {
    if (mv != null) {
      ctx.dispatch(SearchDetailsActionCreator.getMv(mv.result.mvs));
    }
  });
  _searchSongData(ctx.state.searchContent).then((song) {
    if (song != null) {
      List<String> ids = List();
      song.result.songs.forEach((song){
        ids.add('${song.id}');
      });
      _getSongDetails(ids.join(',')).then((de){
        List<SongBeanEntity> newList = List();
        de.songs.forEach((details) {
          var singerStr = '';
          var ar = details.ar;
          ar.forEach((singer) {
            singerStr += ' ${singer.name} ';
          });
          SongBeanEntity songBeanEntity = SongBeanEntity(
              name: details.name,
              id: details.id.toString(),
              picUrl: details.al.picUrl,
              singer: singerStr,
              mv: details.mv);
          newList.add(songBeanEntity);
        });
        ctx.dispatch(SearchDetailsActionCreator.getSong(newList));
      });
    }
  });
}

Future<SearchSongEntity> _searchSongData(content) async {
  // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var answer = await search({'keywords': content, 'type': 1},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SearchSongEntity.fromJson(answer.body) : null;
}

Future<SearchSheetEntity> _searchSheetData(content) async {
  // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var answer = await search({'keywords': content, 'type': 1000},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SearchSheetEntity.fromJson(answer.body) : null;
}

Future<SearchMvEntity> _searchMvData(content) async {
  // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var answer = await search({'keywords': content, 'type': 1004},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SearchMvEntity.fromJson(answer.body) : null;
}

Future<SearchSingerEntity> _searchSingerData(content) async {
  // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var answer = await search({'keywords': content, 'type': 100},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SearchSingerEntity.fromJson(answer.body) : null;
}

Future<SongDeEntity> _getSongDetails(ids) async {
  // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var answer = await song_detail({'ids': ids},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SongDeEntity.fromJson(answer.body) : null;
}
