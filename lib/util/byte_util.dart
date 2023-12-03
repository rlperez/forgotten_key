import 'dart:io';
import 'dart:typed_data';

class ByteUtils {
  static String readString(RandomAccessFile file, int length) {
    final name = file.readSync(length);
    return String.fromCharCodes(name);
  }

  static int readInt32(RandomAccessFile file, {Endian endian = Endian.little}) {
    final value = _byteData(file, 4).getInt32(0, endian);
    return value;
  }

  static int readUInt32(RandomAccessFile file,
      {Endian endian = Endian.little}) {
    final value = _byteData(file, 4).getUint32(0, endian);
    return value;
  }

  static int readUInt16(RandomAccessFile file) {
    final value = _byteData(file, 2).getUint16(0);
    return value;
  }

  static int readUInt8(RandomAccessFile file) {
    final value = _byteData(file, 1).getUint8(0);
    return value;
  }

  static ByteData _byteData(RandomAccessFile file, int length) {
    final bytes = file.readSync(length);
    final byteData = ByteData.sublistView(bytes, 0, length);
    return byteData;
  }
}
