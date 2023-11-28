import 'package:forgotten_key/util/char_game_info_reader.dart';

class CharGameInfo {
  final String name;
  final String path;

  CharGameInfo({
    required this.name,
    required this.path,
  });

  static Future<CharGameInfo> read(String path) async {
    final info = CharGameInfoReader.read(path);
    return await info;
  }
}
