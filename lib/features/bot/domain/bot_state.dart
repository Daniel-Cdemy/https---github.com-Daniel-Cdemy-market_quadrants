class BotState {
  final List<double> markets;
  const BotState(this.markets);

  BotState updated(int index, double newValue) {
    final copy = List<double>.from(markets);
    copy[index] = newValue;
    return BotState(copy);
  }

  double get sum => markets.fold(0.0, (a, b) => a + b);
}
