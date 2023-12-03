import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/byte_length.dart';
import 'package:forgotten_key/util/char_info_reader.dart';

void main() {
  tearDown(() async {
    if (File('test_file.gam').existsSync()) {
      await File('test_file.gam').delete();
    }
  });

  test('should read valid save game file', () async {
    RandomAccessFile file =
        await File('test/data/000000024-BarbToDruid/BALDUR.gam').open();
    file.setPositionSync(gameInfoByteSize);
    // There are 6 members in this file's party.
    final charInfo = await CharInfoReader(file: file).read(6);

    expect(charInfo, isNotNull);
    expect(charInfo.length, 6);
    for (var character in charInfo) {
      expect(character.unknown0, isNotNull);
      expect(character.partyPosition, isInstanceOf<int>());
      expect(character.creOffset, isInstanceOf<int>());
      expect(character.creSize, isInstanceOf<int>());
      expect(character.unknown1, isNotNull);
      expect(character.currentArea, isNotNull);
      expect(character.playerX, isInstanceOf<int>());
      expect(character.playerY, isInstanceOf<int>());
      expect(character.viewX, isInstanceOf<int>());
      expect(character.viewY, isInstanceOf<int>());
      expect(character.unknown2, isNotNull);
      expect(character.name, hasLength(21));
      expect(character.unknown3, isNotNull);
    }

    // Names are 21 characters long padded with 0x00. The first character is the null terminator.
    // Trell is the player created character and the rest are party NPCs. Non player
    // characters do not have their names displayed in the game on this variable.
    final trell = charInfo.firstWhere((char) => char.name.contains('Trell'));
    expect(trell.toString(), contains('Trell'));
    expect(trell.partyPosition, 0);
    expect(trell, isNotNull);
    file.close();
  });
}
