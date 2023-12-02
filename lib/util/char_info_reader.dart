import 'dart:io';

import 'package:forgotten_key/models/char_info.dart';
import 'package:loggy/loggy.dart';

class CharInfoReader with UiLoggy {
  final String path;
  CharInfoReader(this.path);

  Future<CharInfo> read() async {
    RandomAccessFile? file;

    try {
      // Total content of GameInfo in save file should be 179 bytes
      file = await File(path).open();
      file.setPosition(179);

      final unknown0 = file.readSync(4);
      final partyPosition = _readUInt16(file);
      final creOffset = _readUInt32(file);
      final creSize = _readUInt32(file);
      final unknown1 = file.readSync(12);
      final currentArea = _readString(8, file);
      final playerX = _readUInt16(file);
      final playerY = _readUInt16(file);
      final viewX = _readUInt16(file);
      final viewY = _readUInt16(file);
      final unknown2 = file.readSync(152);
      final name = _readString(21, file);
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
    } catch (e) {
      loggy.error(e);
      rethrow;
    } finally {
      await file?.close();
    }
  }

  int _readUInt16(RandomAccessFile file) {
    final bytes = file.readSync(2);
    return bytes[0] + (bytes[1] << 8);
  }

  int _readUInt32(RandomAccessFile file) {
    final bytes = file.readSync(4);
    return bytes[0] + (bytes[1] << 8) + (bytes[2] << 16) + (bytes[3] << 24);
  }

  String _readString(int bytes, RandomAccessFile file) {
    final header = file.readSync(bytes);
    String value = String.fromCharCodes(header);
    return value;
  }
}
