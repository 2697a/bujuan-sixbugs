import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/song_bean_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class FindState implements Cloneable<FindState> {
  List<BannerBanner> banners;

  List<PersonalResult> sheets;

  List<SongBeanEntity> newSongs;

  bool isLoading;

  @override
  FindState clone() {
    return FindState()
      ..isLoading = isLoading
      ..banners = banners
      ..sheets = sheets
      ..newSongs = newSongs;
  }
}

FindState initState(Map<String, dynamic> args) {
  var findState = FindState();
  findState.isLoading = true;
  return findState;
}
