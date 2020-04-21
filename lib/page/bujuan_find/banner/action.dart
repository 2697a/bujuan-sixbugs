import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/entity/banner_entity.dart';
import 'package:fish_redux/fish_redux.dart';

enum NewBannerAction { openPage,getFm,onTap }

class NewBannerActionCreator {
  static Action onOpenPage(MenuType menuType) {
    return  Action(NewBannerAction.openPage,payload: menuType);
  }

  static Action onGetFm() {
    return  Action(NewBannerAction.getFm);
  }

  static Action onTap(BannerBanner banner) {
    return  Action(NewBannerAction.onTap,payload: banner);
  }
}
