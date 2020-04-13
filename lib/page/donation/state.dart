import 'package:fish_redux/fish_redux.dart';

class DonationState implements Cloneable<DonationState> {

  @override
  DonationState clone() {
    return DonationState();
  }
}

DonationState initState(Map<String, dynamic> args) {
  return DonationState();
}
