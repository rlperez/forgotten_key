import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:forgotten_key/util/game_global_value_reader.dart';
import 'package:forgotten_key/models/game_global_value.dart';

void main() {
  test('should read global values', () async {
    final file =
        await File('test/data/000000024-BarbToDruid/BALDUR.gam').open();
    final reader = GameGlobalValueReader(file: file);
    final values = await reader.read(116596, 161);

    expect(values, isNotNull);
    expect(values.length, 161);
    expect(values.first.name, 'AR0700');
    expect(values.first.value, 0);
    expect(values.first.unknown0, [0, 0, 0, 0, 0, 0, 0, 0]);
    expect(values.first.unknown2, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  });
}
