import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/char_game_info_reader.dart';
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
    expect(
        charInfo.firstWhere((char) => char.name.contains('Trell')), isNotNull);
    file.close();
  });

  test('should throw an exception if the header is not GAME', () async {
    final file = await File('test_file.gam').create();
    final randomAccessFile = await file.open(mode: FileMode.write);
    const header = 'WAAA';
    await randomAccessFile.writeString(header);
    await randomAccessFile.flush();
    await randomAccessFile.close();

    final reader = CharGameInfoReader('test_file.gam');

    expect(
        () => reader.read(),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() ==
                'Exception: Invalid header of WAAA. It should be GAME.')));
  });

  test('should throw an exception if the version is not V2.0 or V2.1',
      () async {
    final file = await File('test_file.gam').create();
    final randomAccessFile = await file.open(mode: FileMode.write);
    const version = 'V2.2';
    await randomAccessFile.writeString('GAME');
    await randomAccessFile.writeString(version);
    await randomAccessFile.flush();
    await randomAccessFile.close();

    final reader = CharGameInfoReader('test_file.gam');
    expect(
        () => reader.read(),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() ==
                "Exception: Invalid version of 'V2.2'. Only 'V2.0' and 'V2.1' are supported. Version 'V2.2' was found.")));
  });
}
