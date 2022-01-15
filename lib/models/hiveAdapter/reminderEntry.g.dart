// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reminderEntry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderEntryAdapter extends TypeAdapter<ReminderEntry> {
  @override
  final int typeId = 2;

  @override
  ReminderEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderEntry()
      ..id = fields[0] as String
      ..taskId = fields[1] as String
      ..status = fields[2] as bool
      // Since hive doesnt support TimeOfDay, 
      // & we store it as DateTime,
      // so we need to convert it back to TimeOfDay
      ..reminderTime = dateTimeToTimeOfDay(fields[3])
      ..tempOffDate = fields[4];
  }

  @override
  void write(BinaryWriter writer, ReminderEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      // Since hive doesnt support TimeOfDay, 
      // so we store it as DateTime instead
      ..write(timeOfDayToDateTime(obj.reminderTime))
      ..writeByte(4)
      ..write(obj.tempOffDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
