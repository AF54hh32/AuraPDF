// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HivItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivitemAdapter extends TypeAdapter<Hivitem> {
  @override
  final typeId = 0;

  @override
  Hivitem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hivitem(fields[0] as String, fields[1] as String);
  }

  @override
  void write(BinaryWriter writer, Hivitem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fileName)
      ..writeByte(1)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivitemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
