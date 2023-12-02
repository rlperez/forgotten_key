import 'dart:io';

import 'package:forgotten_key/models/char_game_info.dart';
import 'package:loggy/loggy.dart';

class CharGameInfoReader with UiLoggy {
  final String path;
  CharGameInfoReader(this.path);

  Future<CharGameInfo> read() async {
    RandomAccessFile? file;

    try {
      file = await File(path).open();
      final header = _readHeader(file);
      final gameVersion = _readVersion(file);

      return CharGameInfo(
        name: 'Unknown',
        path: path,
        header: header,
        gameVersion: gameVersion,
      );
    } catch (e) {
      loggy.error(e);
      rethrow;
    } finally {
      if (file != null) {
        await file.close();
      }
    }
  }

  String _readHeader(RandomAccessFile file) {
    final header = file.readSync(4);
    String headerString = String.fromCharCodes(header);
    logDebug("header: $headerString");

    if (headerString != 'GAME') {
      logError('Invalid header');
      throw Exception('Invalid header of $headerString. It should be GAME.');
    }
    return headerString;
  }

  String _readVersion(RandomAccessFile file) {
    final version = file.readSync(4);
    String versionString = String.fromCharCodes(version);
    logDebug("gameVersion: $versionString");

    if (versionString != 'V2.0' && versionString != 'V2.1') {
      logError('Invalid version: $versionString');
      throw Exception(
          "Invalid version of '$versionString'. Only 'V2.0' and 'V2.1' are supported. Version '$versionString' was found.");
    }

    return versionString;
  }
}
