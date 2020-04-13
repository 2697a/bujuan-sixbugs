import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DonationState> buildEffect() {
  return combineEffects(<Object, Effect<DonationState>>{
    DonationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DonationState> ctx) {
}
