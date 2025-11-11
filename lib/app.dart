import 'package:flutter/material.dart';
import 'features/bot/presentation/pages/dashboard_page.dart';

class MarketApp extends StatelessWidget {
  const MarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ein Markt, vier Zustände – Riverpod',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const DashboardPage(),
    );
  }
}
