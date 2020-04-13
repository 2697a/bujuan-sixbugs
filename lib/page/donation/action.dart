import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DonationAction { action }

class DonationActionCreator {
  static Action onAction() {
    return const Action(DonationAction.action);
  }
}
