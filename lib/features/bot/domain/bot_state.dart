class BotState {
  final List<double> markets; // [Q0, Q1, Q2, Q3]
  const BotState(this.markets);

  BotState updated(int index, double newValue) {
    final copy = List<double>.from(markets);
    copy[index] = newValue;
    return BotState(copy);
  }

  double get sum => markets.fold(0.0, (a, b) => a + b);
}
