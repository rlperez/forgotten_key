import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
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
    expect(trell, isNotNull);
    file.close();
  });

  test('should throw an exception if the file is incomplete', () async {
    final file = await File('test_file.gam').create();
    final randomAccessFile = await file.open(mode: FileMode.write);
    const version = 'V2.1';
    await randomAccessFile.writeString('GAME');
    await randomAccessFile.writeString(version);
    await randomAccessFile.flush();
    await randomAccessFile.setPosition(0);

    final reader = CharInfoReader(file: randomAccessFile);
    expect(
        reader.read(1),
        throwsA(predicate((e) =>
            e is RangeError &&
            e.toString() ==
                "RangeError (index): Index out of range: no indices are valid: 0")));
  });
}
