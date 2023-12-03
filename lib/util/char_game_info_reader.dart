import 'dart:io';

import 'package:forgotten_key/models/char_game_info.dart';
import 'package:forgotten_key/util/byte_util.dart';
import 'package:forgotten_key/util/char_info_reader.dart';
import 'package:forgotten_key/util/game_global_value_reader.dart';
import 'package:loggy/loggy.dart';

class CharGameInfoReader with UiLoggy {
  final String path;
  CharGameInfoReader(this.path);

  Future<CharGameInfo> read() async {
    RandomAccessFile? file;

    try {
      // Total content of GameInfo in save file should be 179 bytes
      file = await File(path).open();
      final header = _readHeader(file);
      final gameVersion = _readVersion(file);
      // Read the current save game time. Every 300 game time units is 1 hour. The actual displayed game time is 2100 units more than is displayed.
      final gameTime = ByteUtils.readUInt32(file);
      final unknown0 = file.readSync(12);
      final partyGold = ByteUtils.readUInt32(file);
      final unknown1 = file.readSync(4);
      final inPartyCharOffset = ByteUtils.readUInt32(file);
      final inPartyCharCount = ByteUtils.readUInt32(file);
      final unknown2 = file.readSync(8);
      final outPartyCharOffset = ByteUtils.readUInt32(file);
      final outPartyCharCount = ByteUtils.readUInt32(file);
      final globalVarOffset = ByteUtils.readUInt32(file);
      final globalVarCount = ByteUtils.readUInt32(file);
      final areaRes = file.readSync(8);
      final unknown3 = file.readSync(4);
      final journalCount = ByteUtils.readUInt32(file);
      final journalOffset = ByteUtils.readUInt32(file);
      final partyReputation = ByteUtils.readUInt8(file);
      final unknown4 = file.readSync(19);
      final afterJournalOffset = ByteUtils.readUInt32(file);
      final unknown5 = file.readSync(72);
      // Characters should be in party and out party count times
      final characters =
          await CharInfoReader(file: file).read(inPartyCharCount);
      final globalVars = await GameGlobalValueReader(file: file)
          .read(globalVarOffset, globalVarCount);

      return CharGameInfo(
        path: path,
        header: header,
        gameVersion: gameVersion,
        gameTime: gameTime,
        unknown0: unknown0,
        partyGold: partyGold,
        unknown1: unknown1,
        inPartyCharOffset: inPartyCharOffset,
        inPartyCharCount: inPartyCharCount,
        unknown2: unknown2,
        outPartyCharOffset: outPartyCharOffset,
        outPartyCharCount: outPartyCharCount,
        globalVarOffset: globalVarOffset,
        globalVarCount: globalVarCount,
        areaRes: areaRes,
        unknown3: unknown3,
        journalCount: journalCount,
        journalOffset: journalOffset,
        partyReputation: partyReputation,
        unknown4: unknown4,
        afterJournalOffset: afterJournalOffset,
        unknown5: unknown5,
        characters: characters,
        globalVars: globalVars,
      );
    } catch (e) {
      loggy.error(e);
      rethrow;
    } finally {
      await file?.close();
    }
  }

  String _readHeader(RandomAccessFile file) {
    String headerString = ByteUtils.readString(file, 4);
    logDebug("header: $headerString");

    if (headerString != 'GAME') {
      logError('Invalid header');
      throw Exception('Invalid header of $headerString. It should be GAME.');
    }
    return headerString;
  }

  String _readVersion(RandomAccessFile file) {
    String versionString = ByteUtils.readString(file, 4);
    logDebug("gameVersion: $versionString");

    if (versionString != 'V2.0' && versionString != 'V2.1') {
      logError('Invalid version: $versionString');
      throw Exception(
          "Invalid version of '$versionString'. Only 'V2.0' and 'V2.1' are supported. Version '$versionString' was found.");
    }

    return versionString;
  }
}
