import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/bot_controller.dart';
import '../domain/bot_state.dart';

final botProvider = StateNotifierProvider<BotController, BotState>(
  (ref) => BotController(),
);
