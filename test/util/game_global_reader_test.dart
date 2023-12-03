import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/game_global_value_reader.dart';

void main() {
  test('should read global values', () async {
    final file =
        await File('test/data/000000024-BarbToDruid/BALDUR.gam').open();
    final reader = GameGlobalValueReader(file: file);
    // The calculated offset for this save file is 116596 and the count is 161.
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
}
