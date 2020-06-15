import 'dart:convert';
import 'dart:io';

import 'package:bujuan/api/netease_cloud_music.dart';
import 'package:bujuan/constant/play_state.dart';
import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/login_entity.dart';
import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/services.dart';
import 'package:flutterstarrysky/flutter_starry_sky.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'package:path_provider/path_provider.dart';

class NetUtils {
  static final NetUtils _netUtils = NetUtils._internal(); //1
  factory NetUtils() {
    return _netUtils;
  }
  NetUtils._internal();

  //统一请求
  Future<Map> _doHandler(String url, [Map param = const {}]) async {
    var answer = await cloudMusicApi(url, parameter: param, cookie: await _getCookie());
    var map;
    if (answer.status == 200) {
      if (answer.cookie != null && answer.cookie.length > 0) {
        await _saveCookie(answer.cookie);
      }
      map = answer.body;
    }
    return map;
  }

  //保存cookie
  Future<void> _saveCookie(List<Cookie> cookies) async{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cookie = new PersistCookieJar(dir: tempPath, ignoreExpires: true);
    cookie.saveFromResponse(Uri.parse("https://music.163.com/weapi/"), cookies);
  }


  //获取cookie
  Future<List<Cookie>> _getCookie() async{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cookie = new PersistCookieJar(dir: tempPath, ignoreExpires: true);
    return cookie.loadForRequest(Uri.parse('https://music.163.com/weapi/'));
  }

  //手机号登录
  Future<LoginEntity> loginByPhone(String phone, String password) async {
    var login;
    var map = await _doHandler("/login/cellphone", {"phone": phone, "password": password});
    if(map!=null){
      login = LoginEntity.fromJson(map);
    }
    return login;
  }

  //邮箱登录
  Future<LoginEntity> loginByEmail(String email,String password) async{
    var login;
    var map = await _doHandler('/login',{'email':email,'password':password});
    if(map!=null) login = LoginEntity.fromJson(map);
    return login;
  }

  //获取歌单详情
  Future<SheetDetailsEntity> getPlayListDetails(id) async{
    SheetDetailsEntity sheetDetails;
    var map = await _doHandler('/playlist/detail',{'id':id});
    if(map!=null) sheetDetails = SheetDetailsEntity.fromJson(map);
    var trackIds2 = sheetDetails.playlist.trackIds;
    List<int> ids = [];
    Future.forEach(trackIds2, (id)=>ids.add(id.id));
    var list = await getSongDetails(ids.join(','));
    sheetDetails.playlist.tracks = list;
    return sheetDetails;
  }

  //获取歌曲详情
  Future<List<SheetDetailsPlaylistTrack>> getSongDetails(ids) async{
    var songDetails;
    var map = await _doHandler('/song/detail',{'ids':ids});
    if(map!=null){
      var body = map['songs'];
      List<SheetDetailsPlaylistTrack> songs = [];
      await Future.forEach(body, (element){
        var sheetDetailsPlaylistTrack = SheetDetailsPlaylistTrack.fromJson(element);
        songs.add(sheetDetailsPlaylistTrack);
      });
      songDetails = songs;
    }
    return songDetails;
  }

  //每日推荐
  Future<TodaySongEntity> getTodaySongs() async{
    var todaySongs;
    var map = await _doHandler('/recommend/songs');
    if(map!=null) return TodaySongEntity.fromJson(map);
    return todaySongs;
  }

  //获取个人信息
  Future<UserProfileEntity> getUserProfile(userId) async{
    var profile;
    var map = await _doHandler("/user/detail",{'uid':userId});
    if(map!=null) profile = UserProfileEntity.fromJson(Map<String, dynamic>.from(map));
    return profile;
  }

  //获取用户歌单
  Future<UserOrderEntity> getUserPlayList(userId)async{
    var playlist;
    var map = await _doHandler('/user/playlist',{'uid':userId});
    if(map!=null) playlist = UserOrderEntity.fromJson(map);
    return playlist;
  }

  //推荐歌单
  Future<PersonalEntity> getRecommendResource()async{
    var playlist;
    var map = await _doHandler('/personalized');
    if(map!=null) playlist = PersonalEntity.fromJson(map);
    return playlist;
  }

  //banner
  Future<BannerEntity> getBanner() async{
    var banner;
    var map = await _doHandler('/banner');
    if(map!=null) banner = BannerEntity.fromJson(map);
    return banner;
  }

  //新歌推荐
  Future<NewSongEntity> getNewSongs() async{
    var newSongs;
    var map = await _doHandler('/personalized/newsong');
    if(map!=null) newSongs = NewSongEntity.fromJson(map);
    return newSongs;
  }

  Future<String> getSongUrl(songId) async{
    var songUrl = '';
    var map = await _doHandler('/song/url',{'id': songId, 'br':'320000'});
    if(map!=null){
      songUrl = map['data'][0]['url'];
    }
    return songUrl;
  }

  //播放音乐
  Future setPlayListAndPlayById(List<SongInfo> list,SongInfo songInfo,String id) async{
    var playList = await FlutterStarrySky().getPlayList();
    if(playList==null) await GlobalStore.store
        .dispatch(GlobalActionCreator.changeCurrSong(songInfo));
    await FlutterStarrySky().setPlayListAndPlayById(list, songInfo, '$id');
  }
  //监听原生返回
  Future listenerBujuanMusic() async{
     FlutterStarrySky().getChannel().setMethodCallHandler((call) =>  _platformCallHandler(call));
  }

  Future<dynamic> _platformCallHandler(MethodCall call) async {
    var method = call.method;
    print('object==========${method}======${call.arguments.toString()}');
    var arguments = call.arguments;
    if(method=='currSong'){
      //更新当前播放的歌曲
      if(arguments!=null)
        await GlobalStore.store
            .dispatch(GlobalActionCreator.changeCurrSong(SongInfo.fromJson(jsonDecode(arguments))));
    }else if(method=='getUrl'){
      //获取歌曲url
      return await NetUtils().getSongUrl(arguments);
    }else if(method=='state'){
      if(arguments=='start'){
        await GlobalStore.store
            .dispatch(GlobalActionCreator.changePlayState(PlayStateType.Playing));
      }else if(arguments=='stop'){
        await GlobalStore.store
            .dispatch(GlobalActionCreator.changePlayState(PlayStateType.Stop));
      }else if(arguments=='pause'||arguments=='completion'){
        await GlobalStore.store
            .dispatch(GlobalActionCreator.changePlayState(PlayStateType.Pause));
      }
    }
  }
}
