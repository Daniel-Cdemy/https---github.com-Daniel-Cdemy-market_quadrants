import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/bot_state.dart';
import '../shared/utils.dart';

class BotController extends StateNotifier<BotState> {
  BotController() : super(const BotState([44.0, 7.0, 8.0, 25.0]));

  void applyDeltaFromQuadrant(int quadrantIndex, double delta) {
    final target = diagonalOf(quadrantIndex);
    final nextValue = state.markets[target] + delta;
    state = state.updated(target, nextValue);
  }
}
