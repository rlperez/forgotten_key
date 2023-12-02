import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/char_game_info_reader.dart';

void main() {
  tearDown(() async {
    if (File('test_file.gam').existsSync()) {
      await File('test_file.gam').delete();
    }
  });

  test('should read valid save game file', () async {
    final gameInfo =
        await CharGameInfoReader('test/data/000000024-BarbToDruid/BALDUR.gam')
            .read();
    expect(gameInfo, isNotNull);
    expect(gameInfo.header, 'GAME');
    expect(gameInfo.gameVersion, 'V2.0');
    expect(gameInfo.gameTime, 122818);
    expect(gameInfo.partyGold, 1959);
    expect(gameInfo.inPartyCharOffset, 180);
    expect(gameInfo.inPartyCharCount, 6);
    expect(gameInfo.outPartyCharOffset, 31056);
    expect(gameInfo.outPartyCharCount, 34);
    expect(gameInfo.globalVarOffset, 116596);
    expect(gameInfo.globalVarCount, 161);
    expect(gameInfo.journalCount, 52);
    expect(gameInfo.journalOffset, 130120);
    expect(gameInfo.partyReputation, 140);
    expect(gameInfo.afterJournalOffset, 130744);
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
