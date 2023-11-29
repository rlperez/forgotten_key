import 'dart:io';

import 'package:forgotten_key/models/char_game_info.dart';
import 'package:loggy/loggy.dart';

class CharGameInfoReader with UiLoggy {
  final String path;
  CharGameInfoReader(this.path);

  Future<CharGameInfo> read() async {
    try {
      final file = await File(path).open();
      await file.close();
      return CharGameInfo(
        name: 'Unknown',
        path: path,
      );
    } catch (e) {
      return CharGameInfo(
        name: 'Unknown',
        path: path,
      );
    }
  }
}
