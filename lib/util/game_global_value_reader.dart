import 'dart:io';

import 'package:forgotten_key/models/game_global_value.dart';
import 'package:loggy/loggy.dart';

class GameGlobalValueReader with UiLoggy {
  final RandomAccessFile file;
  GameGlobalValueReader({required this.file});

  Future<List<GameGlobalValue>> read(
      int globalVarOffset, int globalVarCount) async {
    file.setPositionSync(globalVarOffset);
    List<GameGlobalValue> values = [];

    try {
      for (var i = 0; i < globalVarCount; i++) {
        final name = _readString(32);
        final unknown0 = file.readSync(8);
        final value = _readInt32();
        final unknown2 = file.readSync(40);

        values.add(GameGlobalValue(
          name: name,
          unknown0: unknown0,
          value: value,
          unknown1: unknown2,
        ));
      }
    } catch (e) {
      logError(e);
      rethrow;
    }

    return values;
  }

  String _readString(int length) {
    final name = file.readSync(length);
    return String.fromCharCodes(name);
  }

  int _readInt32() {
    final bytes = file.readSync(4);
    return bytes[0] +
        bytes[1] * 256 +
        bytes[2] * 256 * 256 +
        bytes[3] * 256 * 256 * 256;
  }
}
