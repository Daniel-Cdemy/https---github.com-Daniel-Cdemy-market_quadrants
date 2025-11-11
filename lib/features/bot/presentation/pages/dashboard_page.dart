import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers.dart';
import '../../shared/utils.dart';
import '../widgets/market.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bot = ref.watch(botProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Summe: ${bot.sum.toStringAsFixed(2)}'),
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
              children: List.generate(4, (i) {
                final value = bot.markets[i];
                final target = diagonalOf(i);
                return MarketQuadrant(
                  index: i,
                  value: value,
                  targetIndex: target,
                  onDelta: (delta) => ref
                      .read(botProvider.notifier)
                      .applyDeltaFromQuadrant(i, delta),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
