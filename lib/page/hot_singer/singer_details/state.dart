import 'package:fish_redux/fish_redux.dart';

class SingerDetailsState implements Cloneable<SingerDetailsState> {
  bool isShowLoading;
  String singerId;
  String singerPic;
  String singerName;
  List<String> tabs;

  @override
  SingerDetailsState clone() {
    return SingerDetailsState()
      ..isShowLoading = isShowLoading
      ..singerId = singerId
      ..singerName = singerName
      ..tabs =tabs
      ..singerPic = singerPic;
  }
}

SingerDetailsState initState(Map<String, dynamic> args) {
  var singerDetailsState = SingerDetailsState();
  var id = args['id'];
  var url = args['pic'];
  var name = args['name'];
  singerDetailsState.singerId = '$id';
  singerDetailsState.singerPic = url;
  singerDetailsState.singerName = name;
  singerDetailsState.isShowLoading = true;
  singerDetailsState.tabs = <String>[
    "单曲",
    "专辑",
    "视频",
  ];
  return singerDetailsState;
}
