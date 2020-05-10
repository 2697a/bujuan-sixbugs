import 'dart:convert';

import 'package:bujuan/api/module.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/singer_album.dart';
import 'package:bujuan/entity/singer_song.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';
import '../../../bujuan_music.dart';
import 'action.dart';
import 'state.dart';

Effect<SingerDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<SingerDetailsState>>{
    Lifecycle.initState: _onInit,
    SingerDetailsAction.playSong: _onPlaySong
  });
}


void _onInit(Action action, Context<SingerDetailsState> ctx) async{
  var singerSong = await _getSingerDetails(ctx.state.singerId);
  if(singerSong!=null){
    ctx.dispatch(SingerDetailsActionCreator.onSingerBean(singerSong.artist));
    ctx.dispatch(SingerDetailsActionCreator.onSingerSongs(singerSong.hotSongs));
    ctx.state.isShowLoading = false;
  }
  var singerAlbum = await _getSingerAlbum(ctx.state.singerId);
  if(singerAlbum!=null){
    ctx.dispatch(SingerDetailsActionCreator.ongetSingerAlbum(singerAlbum.hotAlbums));
  }
}
void _onPlaySong(Action action, Context<SingerDetailsState> ctx) async{
  SpUtil.putBool( ISFM, false);
  var index2 = action.payload;
  GlobalStore.store
      .dispatch(GlobalActionCreator.changeCurrSong(ctx.state.songs[index2]));
  SpUtil.putObjectList( playSongListHistory, ctx.state.songs);

  var jsonEncode2 = jsonEncode( ctx.state.songs);
  await BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
}

Future<SingerSong> _getSingerDetails(id) async{
  var answer = await artists({'id':id},await BuJuanUtil.getCookie());
   if(answer.status==200){
     var body = answer.body;
     var singerSong = SingerSong.fromJson(body);
     if(singerSong.code==200){
       return singerSong;
     }else{
       return null;
     }
   }else{
     return null;
   }
}

Future<SingerAlbum> _getSingerAlbum(id) async{
  var answer = await album({'id':id},await BuJuanUtil.getCookie());
  if(answer.status==200){
    var body = answer.body;
    var singerAlbum = SingerAlbum.fromJson(body);
    if(singerAlbum.code==200){
      return singerAlbum;
    }else{
      return null;
    }
  }else{
    return null;
  }
}