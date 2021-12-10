// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationDetailAdapter extends TypeAdapter<NotificationDetail> {
  @override
  final int typeId = 2;

  @override
  NotificationDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationDetail()
      ..id = fields[0] as String
      ..taskId = fields[1] as String
      ..notificationTime = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, NotificationDetail obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.notificationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
