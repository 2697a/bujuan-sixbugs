import 'package:bujuan/entity/banner_entity.dart';
import 'package:fish_redux/fish_redux.dart';

class NewBannerState implements Cloneable<NewBannerState> {
  List<BannerBanner> banners;
  @override
  NewBannerState clone() {
    return NewBannerState()..banners = banners;
  }
}

NewBannerState initState(Map<String, dynamic> args) {
  var newBannerState = NewBannerState();
  newBannerState.banners=[];
  return newBannerState;
}
