enum ByteLengthKeys {
  header,
  version,
  gameTime,
  unknown0,
  partyGold,
  unknown1,
  inPartyCharOffset,
  inPartyCharCount,
  unknown2,
  outPartyCharOffset,
  outPartyCharCount,
  globalVarOffset,
  globalVarCount,
  areaRes,
  unknown3,
  journalCount,
  journalOffset,
  partyReputation,
  unknown4,
  afterJournalOffset,
  unknown5,
  charUnknown0,
  charPartyPosition,
  charCreOffset,
  charCreSize,
  charUnknown1,
  charCurrentArea,
  charPlayerX,
  charPlayerY,
  charViewX,
  charViewY,
  charUnknown2,
  charName,
  charUnknown3,
  gameGlobalValueName,
  gameGlobalValueUnknown0,
  gameGlobalValueValue,
  gameGlobalValueUnknown1,
}

int byteLength(ByteLengthKeys key) {
  return byteLengthValues[key]!;
}

const Map<ByteLengthKeys, int> byteLengthValues = {
  ByteLengthKeys.header: 4,
  ByteLengthKeys.version: 4,
  ByteLengthKeys.gameTime: 4,
  ByteLengthKeys.unknown0: 12,
  ByteLengthKeys.partyGold: 4,
  ByteLengthKeys.unknown1: 4,
  ByteLengthKeys.inPartyCharOffset: 4,
  ByteLengthKeys.inPartyCharCount: 4,
  ByteLengthKeys.unknown2: 8,
  ByteLengthKeys.outPartyCharOffset: 4,
  ByteLengthKeys.outPartyCharCount: 4,
  ByteLengthKeys.globalVarOffset: 4,
  ByteLengthKeys.globalVarCount: 4,
  ByteLengthKeys.areaRes: 8,
  ByteLengthKeys.unknown3: 4,
  ByteLengthKeys.journalCount: 4,
  ByteLengthKeys.journalOffset: 4,
  ByteLengthKeys.partyReputation: 1,
  ByteLengthKeys.unknown4: 19,
  ByteLengthKeys.afterJournalOffset: 4,
  ByteLengthKeys.unknown5: 72,
  ByteLengthKeys.charUnknown0: 2,
  ByteLengthKeys.charPartyPosition: 2,
  ByteLengthKeys.charCreOffset: 4,
  ByteLengthKeys.charCreSize: 4,
  ByteLengthKeys.charUnknown1: 12,
  ByteLengthKeys.charCurrentArea: 8,
  ByteLengthKeys.charPlayerX: 2,
  ByteLengthKeys.charPlayerY: 2,
  ByteLengthKeys.charViewX: 2,
  ByteLengthKeys.charViewY: 2,
  ByteLengthKeys.charUnknown2: 152,
  ByteLengthKeys.charName: 21,
  ByteLengthKeys.charUnknown3: 139,
  ByteLengthKeys.gameGlobalValueName: 32,
  ByteLengthKeys.gameGlobalValueUnknown0: 8,
  ByteLengthKeys.gameGlobalValueValue: 4,
  ByteLengthKeys.gameGlobalValueUnknown1: 40,
};
