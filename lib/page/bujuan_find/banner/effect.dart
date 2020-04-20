import 'dart:convert';
import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/fm_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/song_de_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<NewBannerState> buildEffect() {
  return combineEffects(<Object, Effect<NewBannerState>>{NewBannerAction.openPage: _onOpenPage, NewBannerAction.getFm: _onFm, NewBannerAction.onTap: _onTap});
}

void _onOpenPage(Action action, Context<NewBannerState> ctx) {
  MenuType menuType = action.payload;
  switch (menuType) {
    case MenuType.TODAY:
      if (BuJuanUtil.isLogin())
        Navigator.of(ctx.context).pushNamed('today', arguments: null);
      else
        BuJuanUtil.showToast('登录后才能拥有');
      break;
    case MenuType.SHEET:
      Navigator.of(ctx.context).pushNamed('sheet_square', arguments: null);
      break;
    case MenuType.SINGER:
      // TODO: Handle this case.
      Navigator.of(ctx.context).pushNamed('hot_singer', arguments: null);
      break;
    case MenuType.RADIO:
      // TODO: Handle this case.
      break;
    case MenuType.FM:
      // TODO: Handle this case.
      break;
  }
}

void _onTap(Action action, Context<NewBannerState> ctx) {
  BannerBanner payload = action.payload;
//  1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var targetType = payload.targetType;
  switch (targetType) {
    case 1:
      _getSongDetails('${payload.targetId}').then((song) {
        if (song != null && song.songs.length > 0) {
          List<SongBeanEntity> newList = List();
          song.songs.forEach((details) {
            var singerStr = '';
            var ar = details.ar;
            ar.forEach((singer) {
              singerStr += ' ${singer.name} ';
            });
            SongBeanEntity songBeanEntity = SongBeanEntity(name: details.name, id: details.id.toString(), picUrl: details.al.picUrl, singer: singerStr, mv: details.mv);
            newList.add(songBeanEntity);
          });

          SpUtil.putBool(Constants.ISFM, false);
          var index2 = 0;
          GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(newList[index2]));
          SpUtil.putObjectList(Constants.playSongListHistory, newList);
          var jsonEncode2 = jsonEncode(newList);
          BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
        }
      });
      break;
    case 10:
      break;
    case 100:
      break;
    case 1004:
      Navigator.of(ctx.context).pushNamed('mv_play', arguments: {'mvId': payload.targetId}); //注意2
      break;
    case 1000:
      break;
  }
}

void _onFm(Action action, Context<NewBannerState> ctx) {
  _getFm().then((fm) {
    SpUtil.putBool(Constants.ISFM, true);
    List<SongBeanEntity> songs = List();
    fm.data.forEach((data) {
      SongBeanEntity songBeanEntity = SongBeanEntity();
      songBeanEntity.id = data.id.toString();
      songBeanEntity.name = data.name;
      songBeanEntity.singer = data.artists[0].name;
      songBeanEntity.picUrl = data.album.picUrl;
      songBeanEntity.mv = data.mvid;
      songs.add(songBeanEntity);
    });

    GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(songs[0]));
    SpUtil.putObjectList(Constants.playSongListHistory, songs);
    var jsonEncode2 = jsonEncode(songs);
    BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: 0);
  });
}

Future<SongDeEntity> _getSongDetails(ids) async {
  // 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  var answer = await song_detail({'ids': ids},await BuJuanUtil.getCookie());
  return answer.status == 200 ? SongDeEntity.fromJson(answer.body) : null;
}

///personal_fm
Future<FmEntity> _getFm() async {
//  Response sheet = await HttpUtil().get('/personal_fm');
//  var data = sheet.data;
//  var jsonDecode2 = jsonDecode(data);
//  return FmEntity.fromJson(jsonDecode2);
}
