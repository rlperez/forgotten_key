import 'dart:typed_data';

// 84 bytes total
class GameGlobalValue {
  final String name;
  final Uint8List unknown0;
  final int value;
  final Uint8List unknown2;

  GameGlobalValue({
    required this.name,
    required this.unknown0,
    required this.value,
    required this.unknown2,
  });

  @override
  String toString() {
    return 'GameGlobalValue {name: $name, unknown0: $unknown0, value: $value, unknown2: $unknown2}';
  }
}
