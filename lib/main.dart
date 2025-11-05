import 'package:flutter/material.dart';

void main() => runApp(const MarketApp());

class MarketApp extends StatelessWidget {
  const MarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diagonal Counter',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const LocalStateHomepage(),
    );
  }
}

/// EIN StatefulWidget verwaltet den gesamten State.
/// Keine extra Provider, keine weiteren State-Objekte.
class LocalStateHomepage extends StatefulWidget {
  const LocalStateHomepage({super.key});

  @override
  State<LocalStateHomepage> createState() => _LocalStateHomepageState();
}

class _LocalStateHomepageState extends State<LocalStateHomepage> {
  // Vier Marktwerte (z. B. „Preis“/Score/Counter). Startwerte frei wählbar.
  // Index-Layout (2x2):
  final List<double> _markets = [
    44,
    7,
    8,
    25,
  ].map((e) => e.toDouble()).toList();

  // Diagonale Zuordnung: 0<->3, 1<->2
  int _diagonalOf(int i) => switch (i) {
    0 => 3,
    1 => 2,
    2 => 1,
    3 => 0,
    _ => 0,
  };

  // Änderung anwenden: Button im Feld i verändert den diagonal gegenüberliegenden Markt.
  void _applyDeltaFromQuadrant(int quadrantIndex, double delta) {
    final target = _diagonalOf(quadrantIndex);
    setState(() {
      _markets[target] = (_markets[target] + delta);
    });
  }

  double get _sum => _markets.fold(0.0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summe: ${_sum.toStringAsFixed(2)}'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: List.generate(4, (i) => _buildQuadrant(i)),
            ),
          ),
        ),
      ),
    );
  }

  /// WICHTIG: Das ist KEIN eigenes Widget, sondern nur eine Helper-Methode.
  /// Der State bleibt vollständig hier im StatefulWidget.
  Widget _buildQuadrant(int i) {
    final value = _markets[i];

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Der „Preis“/Counter des aktuellen Quadranten
            Expanded(
              child: Center(
                child: Text(
                  value.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Buttons: ↑ (kauft/erhöht) und ↓ (verkauft/erniedrigt)
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => _applyDeltaFromQuadrant(i, 1),
                    child: const Icon(Icons.arrow_upward),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _applyDeltaFromQuadrant(i, -1),
                    child: const Icon(Icons.arrow_downward),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
