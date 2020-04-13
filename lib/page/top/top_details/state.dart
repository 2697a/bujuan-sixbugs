import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class TopDetailsState implements Cloneable<TopDetailsState> {
  List<SongBeanEntity> list;
  String id;
  bool showLoading;

  @override
  TopDetailsState clone() {
    return TopDetailsState()
      ..list = list
      ..showLoading = showLoading
      ..id = id;
  }
}

TopDetailsState initState(Map<String, dynamic> args) {
  var topDetailsState = TopDetailsState();
//  List<SongBeanEntity> list = args['list'];
  topDetailsState.id = args['id'];
  topDetailsState.showLoading = true;
//  if (list != null) {
//    topDetailsState.list = list;
//    topDetailsState.showLoading = false;
//  }
  return topDetailsState;
}
