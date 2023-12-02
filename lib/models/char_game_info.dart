import 'package:forgotten_key/util/char_game_info_reader.dart';
import 'package:loggy/loggy.dart';

class CharGameInfo with UiLoggy {
  final String name;
  final String path;
  final String header;
  final String gameVersion;
  CharGameInfo(
      {required this.name,
      required this.path,
      required this.header,
      required this.gameVersion});

  static Future<CharGameInfo> read(String path) async {
    final info = CharGameInfoReader(path).read();
    return await info;
  }
}
