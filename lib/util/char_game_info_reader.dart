import 'dart:io';

import 'package:forgotten_key/models/char_game_info.dart';

class CharGameInfoReader {
  static Future<CharGameInfo> read(String path) async {
    final file = await File(path).open();
    final temp = await file.read(4);
    // temp should be "GAME" here
    final size = await file.length();
    print("size = $size");
    await file.close();
    return CharGameInfo(
      name: 'Unknown',
      path: path,
    );
  }
}
