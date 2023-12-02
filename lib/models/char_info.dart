import 'dart:typed_data';

// 352 bytes total
class CharInfo {
  final Uint8List unknown0;
  final int partyPosition; // uint16
  final int creOffset;
  final int creSize;
  final Uint8List unknown1;
  final String currentArea;
  final int playerX; // uint16
  final int playerY; // uint16
  final int viewX; // uint16
  final int viewY; // uint16
  final Uint8List unknown2;
  final String name;
  final Uint8List unknown3;

  CharInfo(
      {required this.unknown0,
      required this.partyPosition,
      required this.creOffset,
      required this.creSize,
      required this.unknown1,
      required this.currentArea,
      required this.playerX,
      required this.playerY,
      required this.viewX,
      required this.viewY,
      required this.unknown2,
      required this.name,
      required this.unknown3});

  @override
  String toString() {
    return 'CharInfo {\n'
        '  unknown0: $unknown0,\n'
        '  partyPosition: $partyPosition,\n'
        '  creOffset: $creOffset,\n'
        '  creSize: $creSize,\n'
        '  unknown1: $unknown1,\n'
        '  currentArea: $currentArea,\n'
        '  playerX: $playerX,\n'
        '  playerY: $playerY,\n'
        '  viewX: $viewX,\n'
        '  viewY: $viewY,\n'
        '  unknown2: $unknown2,\n'
        '  name: $name,\n'
        '  unknown3: $unknown3,\n'
        '}';
  }
}
