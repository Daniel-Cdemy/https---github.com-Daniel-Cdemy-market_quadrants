import 'package:flutter/material.dart';

class MarketQuadrant extends StatelessWidget {
  final int index;                       // 0..3
  final double value;                    // aktueller Marktwert
  final int targetIndex;                 // diagonales Ziel
  final void Function(double) onDelta;   // Callback (+1 / -1)

  const MarketQuadrant({
    super.key,
    required this.index,
    required this.value,
    required this.targetIndex,
    required this.onDelta,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Q$index', style: Theme.of(context).textTheme.titleMedium),
                Text('→ Q$targetIndex', style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Text(
                  value.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => onDelta(1),
                    child: const Icon(Icons.arrow_upward),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onDelta(-1),
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
