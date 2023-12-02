import 'package:forgotten_key/util/char_game_info_reader.dart';

class CharGameInfo {
  final String name;
  final String path;
  final String header;

  CharGameInfo({required this.name, required this.path, required this.header});

  static Future<CharGameInfo> read(String path) async {
    final info = CharGameInfoReader(path).read();
    return await info;
  }
}
