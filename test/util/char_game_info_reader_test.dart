import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/char_game_info_reader.dart';

void main() {
  tearDown(() async {
    if (File('test_file.gam').existsSync()) {
      await File('test_file.gam').delete();
    }
  });

  test('readHeader should return the correct header', () async {
    final file = await File('test_file.gam').create();
    final randomAccessFile = await file.open(mode: FileMode.write);
    const header = 'GAME';
    await randomAccessFile.writeString(header);
    await randomAccessFile.writeString('V2.0');
    await randomAccessFile.flush();
    await randomAccessFile.close();

    final reader = CharGameInfoReader('test_file.gam');
    final result = await reader.read();

    expect(result.header, header);
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

  test('readVersion should return the correct version', () async {
    final file = await File('test_file.gam').create();
    final randomAccessFile = await file.open(mode: FileMode.write);
    const version = 'V2.0';
    await randomAccessFile.writeString('GAME');
    await randomAccessFile.writeString(version);
    await randomAccessFile.flush();
    await randomAccessFile.close();

    final reader = CharGameInfoReader('test_file.gam');
    final result = await reader.read();

    expect(result.gameVersion, version);
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
