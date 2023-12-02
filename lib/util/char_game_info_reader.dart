import 'dart:io';
import 'dart:typed_data';

import 'package:forgotten_key/models/char_game_info.dart';
import 'package:forgotten_key/util/char_info_reader.dart';
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
      final gameTime = _readUInt32(file);
      final unknown0 = file.readSync(12);
      final partyGold = _readUInt32(file);
      final unknown1 = file.readSync(4);
      final inPartyCharOffset = _readUInt32(file);
      final inPartyCharCount = _readUInt32(file);
      final unknown2 = file.readSync(8);
      final outPartyCharOffset = _readUInt32(file);
      final outPartyCharCount = _readUInt32(file);
      final globalVarOffset = _readUInt32(file);
      final globalVarCount = _readUInt32(file);
      final areaRes = file.readSync(8);
      final unknown3 = file.readSync(4);
      final journalCount = _readUInt32(file);
      final journalOffset = _readUInt32(file);
      final partyReputation = _readUInt8(file);
      final unknown4 = file.readSync(19);
      final afterJournalOffset = _readUInt32(file);
      final unknown5 = file.readSync(72);
      final characters =
          await CharInfoReader(file: file).read(inPartyCharCount);
      logDebug('characters: $characters');

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
      );
    } catch (e) {
      loggy.error(e);
      rethrow;
    } finally {
      await file?.close();
    }
  }

  String _readHeader(RandomAccessFile file) {
    final header = file.readSync(4);
    String headerString = String.fromCharCodes(header);
    logDebug("header: $headerString");

    if (headerString != 'GAME') {
      logError('Invalid header');
      throw Exception('Invalid header of $headerString. It should be GAME.');
    }
    return headerString;
  }

  String _readVersion(RandomAccessFile file) {
    final version = file.readSync(4);
    String versionString = String.fromCharCodes(version);
    logDebug("gameVersion: $versionString");

    if (versionString != 'V2.0' && versionString != 'V2.1') {
      logError('Invalid version: $versionString');
      throw Exception(
          "Invalid version of '$versionString'. Only 'V2.0' and 'V2.1' are supported. Version '$versionString' was found.");
    }

    return versionString;
  }

  int _readUInt32(RandomAccessFile file) {
    final offset = file.readSync(4);
    final byteData = ByteData.sublistView(offset);
    final value = byteData.getUint32(0, Endian.little);
    return value;
  }

  int _readUInt8(RandomAccessFile file) {
    final value = file.readByteSync();
    return value;
  }
}
