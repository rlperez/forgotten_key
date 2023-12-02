import 'dart:typed_data';

import 'package:forgotten_key/util/char_game_info_reader.dart';
import 'package:loggy/loggy.dart';

class CharGameInfo with UiLoggy {
  final String path;
  final String header;
  final String gameVersion;
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

  /// Creates a new [CharGameInfo] instance. Arguments are ordered as they appear in file.
  CharGameInfo(
      {required this.path,
      required this.header,
      required this.gameVersion,
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
      required this.unknown5});

  static Future<CharGameInfo> read(String path) async {
    final info = CharGameInfoReader(path).read();
    return await info;
  }

  @override
  String toString() {
    return 'CharGameInfo {\n'
        '  path: $path,\n'
        '  header: $header,\n'
        '  gameVersion: $gameVersion,\n'
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
        '}';
  }
}
