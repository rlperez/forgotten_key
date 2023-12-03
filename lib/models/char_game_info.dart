import 'dart:typed_data';

import 'package:forgotten_key/models/char_info.dart';
import 'package:forgotten_key/models/game_global_value.dart';
import 'package:forgotten_key/util/char_game_info_reader.dart';
import 'package:loggy/loggy.dart';

// 179 total bytes plus inPartyCharCount * 352 bytes plus outPartyCharCount * 352 bytes plus globalVarCount * 84 bytes plus journalCount * 8 bytes
class CharGameInfo with UiLoggy {
  final String path;
  final String header;
  final String version;
  final int gameTime;
  final Uint8List unknown0;
  final int partyGold;
  final Uint8List unknown1;
  final int inPartyCharOffset;
  final int inPartyCharCount;
  final Uint8List unknown2;
  final int outPartyCharOffset;
  final int outPartyCharCount;
  final int globalVarOffset;
  final int globalVarCount;
  final Uint8List areaRes;
  final Uint8List unknown3;
  final int journalCount;
  final int journalOffset;
  final int partyReputation;
  final Uint8List unknown4;
  final int afterJournalOffset;
  final Uint8List unknown5;
  final List<CharInfo> inPartyCharacters;
  final List<CharInfo> outOfPartyCharacters;
  final List<GameGlobalValue> globalVars;

  /// Creates a new [CharGameInfo] instance. Arguments are ordered as they appear in file.
  CharGameInfo(
      {required this.path,
      required this.header,
      required this.version,
      required this.gameTime,
      required this.unknown0,
      required this.partyGold,
      required this.unknown1,
      required this.inPartyCharOffset,
      required this.inPartyCharCount,
      required this.unknown2,
      required this.outPartyCharOffset,
      required this.outPartyCharCount,
      required this.globalVarOffset,
      required this.globalVarCount,
      required this.areaRes,
      required this.unknown3,
      required this.journalCount,
      required this.journalOffset,
      required this.partyReputation,
      required this.unknown4,
      required this.afterJournalOffset,
      required this.unknown5,
      required this.inPartyCharacters,
      required this.outOfPartyCharacters,
      required this.globalVars});

  static Future<CharGameInfo> read(CharGameInfoReader reader) async {
    final info = await reader.read();
    return info;
  }

  @override
  String toString() {
    return 'CharGameInfo {\n'
        '  path: $path,\n'
        '  header: $header,\n'
        '  version: $version,\n'
        '  gameTime: $gameTime,\n'
        '  unknown0: $unknown0,\n'
        '  partyGold: $partyGold,\n'
        '  unknown1: $unknown1,\n'
        '  inPartyCharOffset: $inPartyCharOffset,\n'
        '  inPartyCharCount: $inPartyCharCount,\n'
        '  unknown2: $unknown2,\n'
        '  outPartyCharOffset: $outPartyCharOffset,\n'
        '  outPartyCharCount: $outPartyCharCount,\n'
        '  globalVarOffset: $globalVarOffset,\n'
        '  globalVarCount: $globalVarCount,\n'
        '  areaRes: $areaRes,\n'
        '  unknown3: $unknown3,\n'
        '  journalCount: $journalCount,\n'
        '  journalOffset: $journalOffset,\n'
        '  partyReputation: $partyReputation,\n'
        '  unknown4: $unknown4,\n'
        '  afterJournalOffset: $afterJournalOffset,\n'
        '  unknown5: $unknown5,\n'
        '  inPartyCharacters: [\n'
        '    ${inPartyCharacters.join('\n    ')}\n'
        '  ]\n'
        '  outOfPartyCharacters: [\n'
        '    ${outOfPartyCharacters.join('\n    ')}\n'
        '  ]\n'
        '  globalVars: [\n'
        '    ${globalVars.join('\n    ')}\n'
        '  ]\n'
        '}';
  }
}
