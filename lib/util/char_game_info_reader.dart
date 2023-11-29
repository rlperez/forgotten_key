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

      return CharGameInfo(
        name: 'Unknown',
        path: path,
        header: header,
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
    print(headerString);
    if (headerString != 'GAME') {
      print('Invalid header');
      throw Exception('Invalid header');
    }

    return headerString;
  }
}
