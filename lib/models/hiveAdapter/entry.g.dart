// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryModelAdapter extends TypeAdapter<EntryModel> {
  @override
  final int typeId = 3;

  @override
  EntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntryModel()
      ..id = fields[0] as String
      ..taskId = fields[1] as String
      ..completedDate = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, EntryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.completedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
