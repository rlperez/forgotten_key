import 'dart:io';

import 'package:forgotten_key/models/char_info.dart';
import 'package:forgotten_key/util/byte_util.dart';
import 'package:loggy/loggy.dart';

class CharInfoReader with UiLoggy {
  final RandomAccessFile file;
  CharInfoReader({required this.file});

  Future<List<CharInfo>> read(int charCount) async {
    try {
      // Total content of GameInfo in save file should be 179 bytes
      await file.setPosition(179);
      List<CharInfo> charInfos = [];
      for (int i = 0; i < charCount; i++) {
        charInfos.add(_readCharInfo(file));
      }

      return charInfos;
    } catch (e) {
      loggy.error(e);
      rethrow;
    }
  }

  CharInfo _readCharInfo(RandomAccessFile file) {
    final unknown0 = file.readSync(2);
    final partyPosition = ByteUtils.readUInt16(file);
    final creOffset = ByteUtils.readUInt32(file);
    final creSize = ByteUtils.readUInt32(file);
    final unknown1 = file.readSync(12);
    final currentArea = ByteUtils.readString(file, 8);
    final playerX = ByteUtils.readUInt16(file);
    final playerY = ByteUtils.readUInt16(file);
    final viewX = ByteUtils.readUInt16(file);
    final viewY = ByteUtils.readUInt16(file);
    final unknown2 = file.readSync(152);
    final name = ByteUtils.readString(file, 21);
    final unknown3 = file.readSync(139);

    return CharInfo(
      unknown0: unknown0,
      partyPosition: partyPosition,
      creOffset: creOffset,
      creSize: creSize,
      unknown1: unknown1,
      currentArea: currentArea,
      playerX: playerX,
      playerY: playerY,
      viewX: viewX,
      viewY: viewY,
      unknown2: unknown2,
      name: name,
      unknown3: unknown3,
    );
  }
}
