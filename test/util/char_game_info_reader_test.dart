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
}
