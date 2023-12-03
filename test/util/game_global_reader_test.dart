import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/game_global_value_reader.dart';

void main() {
  test('should read global values', () async {
    final file =
        await File('test/data/000000024-BarbToDruid/BALDUR.gam').open();
    final reader = GameGlobalValueReader(file: file);
    final values = await reader.read(116596, 161);

    expect(values, isNotNull);
    expect(values.length, 161);
    expect(values.first.name,
        'METVAI\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00');
    expect(values.first.value, 1);
    expect(values.first.unknown0, [0, 0, 0, 0, 0, 0, 0, 0]);
    expect(values.first.unknown1, [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0
    ]);
    expect(values.last.value, 0);
    expect(values.last.unknown0, [0, 0, 0, 0, 0, 0, 0, 0]);
    expect(values.last.unknown1, [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0
    ]);
    expect(values.last.name,
        'BD_STORY_MODE\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00');
  });

  test('should throw an exception if the file is invalid', () async {
    final file = await File('test_file.gam').create();
    final randomAccessFile = await file.open(mode: FileMode.write);
    const version = 'V2.1';
    await randomAccessFile.writeString('GAME');
    await randomAccessFile.writeString(version);
    await randomAccessFile.flush();
    await randomAccessFile.setPosition(0);

    final reader = GameGlobalValueReader(file: randomAccessFile);
    expect(
        reader.read(0, 1),
        throwsA(predicate((e) =>
            e is RangeError &&
            e.toString() ==
                "RangeError (index): Index out of range: no indices are valid: 0")));
  });
}
