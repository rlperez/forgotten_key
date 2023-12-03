import 'dart:io';

import 'package:forgotten_key/models/game_global_value.dart';
import 'package:forgotten_key/util/byte_util.dart';
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
        final name = ByteUtils.readString(file, 32);
        final unknown0 = file.readSync(8);
        final value = ByteUtils.readInt32(file);
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
}
