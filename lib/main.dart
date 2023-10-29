import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:syzygy/black_card.dart';

void main() {
  runApp(
    const GameWidget<BlackCardGame>.controlled(
      gameFactory: BlackCardGame.new,
    ),
  );
}
