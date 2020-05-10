import 'dart:convert';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/singer_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:bujuan/entity/top_mv_entity.dart';
import 'package:bujuan/page/top/view.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

class TopPageState implements Cloneable<TopPageState> {
  bool showLoading;
  List<SongBeanEntity> bsList;
  List<SongBeanEntity> newList;
  List<SongBeanEntity> ycList;
  List<SongBeanEntity> hotList;
  List<SingerArtist> artists;
  List<TopMvData> mvs;
  List<TopInfo> topInfos;

  @override
  TopPageState clone() {
    return TopPageState()
      ..bsList = bsList
      ..newList = newList
      ..ycList = ycList
      ..artists = artists
      ..showLoading = showLoading
      ..mvs = mvs
      ..topInfos = topInfos
      ..hotList = hotList;
  }
}

//5: "180106", //UK排行榜周榜
//6: "60198", //美国Billboard周榜
//7: "21845217", //KTV嗨榜
//8: "11641012", //iTunes榜
//9: "120001", //Hit FM Top榜
//10: "60131", //日本Oricon周榜
//11: "3733003", //韩国Melon排行榜周榜
//12: "60255", //韩国Mnet排行榜周榜
//13: "46772709", //韩国Melon原声周榜
//14: "112504", //中国TOP排行榜(港台榜)
//15: "64016", //中国TOP排行榜(内地榜)
//16: "10169002", //香港电台中文歌曲龙虎榜
//17: "4395559", //华语金曲榜
//18: "1899724", //中国嘻哈榜
//19: "27135204", //法国 NRJ EuroHot 30周榜
//20: "112463", //台湾Hito排行榜
//21: "3812895", //Beatport全球电子舞曲榜
//22: "71385702", //云音乐ACG音乐榜
//23: "991319590" //云音乐嘻哈榜
TopPageState initState(Map<String, dynamic> args) {
  var topPageState = TopPageState();
  topPageState.showLoading = true;
  topPageState.topInfos = List()..add(TopInfo('10520166', '电音榜', dy_top))..add(TopInfo('180106', 'UK榜',  uk_top))..add(TopInfo('60131', '日本榜',  rb_top))..add(TopInfo('60198', 'Billl榜',  billl_top))..add(TopInfo('21845217', 'KTV榜',  krv_top))..add(TopInfo('11641012', 'Itunes榜',  itunes_top));
//  var bs = SpUtil.getString('bs', defValue: null);
//  var newListStr = SpUtil.getString('new', defValue: null);
//  var yc = SpUtil.getString('yc', defValue: null);
//  var hot = SpUtil.getString('hot', defValue: null);

//  if (bs != null) {
//    List responseJson = json.decode(bs);
//    topPageState.bsList = responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList();
//  }
//  if (newListStr != null) {
//    List responseJson = json.decode(newListStr);
//    topPageState.newList = responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList();
//  }
//  if (yc != null) {
//    List responseJson = json.decode(yc);
//    topPageState.ycList = responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList();
//  }
//  if (hot != null) {
//    List responseJson = json.decode(hot);
//    topPageState.hotList = responseJson.map((m) => new SongBeanEntity.fromJson(m)).toList();
//    topPageState.showLoading = false;
//  }
  return topPageState;
}
