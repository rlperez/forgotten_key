import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/models/char_game_info.dart';
import 'package:forgotten_key/util/char_game_info_reader.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'char_game_info_test.mocks.dart';

@GenerateMocks([CharGameInfoReader])
void main() {
  test('should call the char game info reader when read is called', () async {
    final mockReader = MockCharGameInfoReader();
    when(mockReader.read()).thenAnswer((_) => Future.value(CharGameInfo(
        path: 'test_file.gam',
        header: 'GAME',
        gameVersion: 'V2.0',
        gameTime: 122818,
        unknown0: Uint8List.fromList([0x00, 0x00]),
        partyGold: 1959,
        unknown1: Uint8List.fromList([0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        inPartyCharOffset: 180,
        inPartyCharCount: 6,
        unknown2: Uint8List.fromList([0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        outPartyCharOffset: 31056,
        outPartyCharCount: 34,
        globalVarOffset: 116596,
        globalVarCount: 161,
        areaRes: Uint8List.fromList([0x00, 0x00, 0x00, 0x00]),
        unknown3: Uint8List.fromList([0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        journalCount: 52,
        journalOffset: 130120,
        partyReputation: 140,
        unknown4: Uint8List.fromList([0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        afterJournalOffset: 130744,
        unknown5: Uint8List.fromList([0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        characters: [],
        globalVars: []))); // Replace `someValue` with the actual value you expect `read` to return

    await CharGameInfo.read(mockReader);
    verify(mockReader.read()).called(1);
  });
}
