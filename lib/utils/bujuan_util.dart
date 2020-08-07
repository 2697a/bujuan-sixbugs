import 'dart:io';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/play_history_entity.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BuJuanUtil {
  static String unix2Time(unix) {
    var minStr, secStr;
    unix = unix ~/ 1000;
    var min = unix ~/ 60;
    var sec = unix - min * 60;
    minStr = '$min';
    secStr = '$sec';
    if (min < 10) minStr = '0$min';
    if (sec < 10) secStr = '0$sec';
    return '$minStr:$secStr';
  }

  static isEmail(String email) {
    return new RegExp(r'^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$').hasMatch(email);
  }

  static Widget getPlayMode(PlayModeType playModeType) {
    Icon icon = Icon(Icons.repeat);
    switch (playModeType) {
      case PlayModeType.REPEAT:
        icon = Icon(Icons.repeat);
        break;
      case PlayModeType.REPEAT_ONE:
        icon = Icon(Icons.repeat_one);
        break;
      case PlayModeType.SHUFFLE:
        icon = Icon(Icons.shuffle);
        break;
    }
    return icon;
  }

//  static void saveCookie(List<Cookie> cookie) {
//    List<SaveCookieEntity> cookies = new List();
//    cookie.forEach((Cookie c) {
//      SaveCookieEntity myCookie = new SaveCookieEntity(
//          name: c.name,
//          value: c.value,
//          maxAge: c.maxAge,
//          domain: c.domain,
//          path: c.path);
//      cookies.add(myCookie);
//    });
//    SpUtil.putObjectList('cookies', cookies);
//  }

  static Future<List<Cookie>> getCookie() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cookie = new PersistCookieJar(dir: tempPath, ignoreExpires: true);
    return cookie.loadForRequest(Uri.parse('https://music.163.com/weapi/'));
  }

  static Future<List<SongInfo>> songToSongInfo(List<SheetDetailsPlaylistTrack> songs) async {
    List<SongInfo> info = [];
    await Future.forEach(songs, (SheetDetailsPlaylistTrack element){
      SongInfo songInfo = SongInfo(songId: '${element.id}',duration:element.dt,songCover: '${element.al.picUrl}',songUrl: '',songName: '${element.name}',artist: '${element.ar[0].name}');
      info.add(songInfo);
    });
    return info;
  }
  static Future<List<SongInfo>> historyToSongInfo(List<PlayHistoryAlldata> songs) async {
    List<SongInfo> info = [];
    await Future.forEach(songs, (PlayHistoryAlldata element){
      SongInfo songInfo = SongInfo(songId: '${element.song.id}',duration:element.song.dt,songCover: '${element.song.al.picUrl}',songUrl: '',songName: '${element.song.name}',artist: '${element.song.ar[0].name}');
      info.add(songInfo);
    });
    return info;
  }
  static Future<List<SongInfo>> todayToSongInfo(List<TodaySongRecommand> songs) async {
    List<SongInfo> info = [];
    await Future.forEach(songs, (TodaySongRecommand element){
      SongInfo songInfo = SongInfo(songId: '${element.id}',duration:element.duration,songCover: '${element.album.picUrl}',songUrl: '',songName: '${element.name}',artist: '${element.artists[0].name}');
      info.add(songInfo);
    });
    return info;
  }

  static List<Lyric> getLyric(String lyric) {
    var split = lyric.split('\n');
    split.forEach((str) {});
  }

  static List<Lyric> analysisLyric(lyric) {
    List<Lyric> lyricList = new List();
    List<String> list = lyric.split("\n");
    list.forEach((String str) {
      if (str != '') {
        if ((str.indexOf("[ar:") != -1) ||
            (str.indexOf("[ti:") != -1) ||
            (str.indexOf("[by:") != -1) ||
            (str.indexOf("[al:") != -1) ||
            str == " ") {
          return;
        }
        int pos1 = str.indexOf("[");
        int pos2 = str.indexOf("]");
        if (pos1 == 0 && pos2 != -1) {
          var substring = str
              .substring(pos1, pos2 + 1)
              .replaceAll("[", '')
              .replaceAll(']', '');
          var text = str.substring(pos2 + 1, str.length);
          int str2millisecond = str2Millisecond(substring);
          Lyric lyricBeanEntity = Lyric(str2millisecond, text);
          lyricList.add(lyricBeanEntity);
        } else {
          return;
        }
      }
    });

    return lyricList;
  }

  static TextStyle getLyricStyle(
      List<Lyric> lyricBean, int index, int currPos) {
    TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
    if (lyricBean[index].time <= currPos) {
      textStyle = TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blue);
    }
    return textStyle;
  }

  static int str2Millisecond(str) {
    if (str.length == 9 || str.length == 8) {
      str = str.replaceAll(":", "."); //00.40.57
      str = str.replaceAll(".", "@"); //00@40@57
      var timeData = str.split("@"); //[00, 40, 57]
      int minute = int.parse(timeData[0]); //数组里的第1个数据是分0
      int second = int.parse(timeData[1]); //数组里的第2个数据是秒40
      int millisecond = int.parse(timeData[2]); //数组里的第3个数据是秒57
      return (minute * 60 * 1000 +
          second * 1000 +
          millisecond); //40000+570=40570
    }
    return 0;
  }

  static bool isLogin() {
    return SpUtil.getInt( USER_ID, defValue: -1) != -1;
  }

  static showToast(msg) {
//    Fluttertoast.showToast(
//        msg: msg,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.white,
//        textColor: Colors.black,
//        fontSize: 14.0);
  }
}

class Lyric {
  int time;
  String lyricStr;

  Lyric(this.time, this.lyricStr);
}
