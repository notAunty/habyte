// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 2;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel()
      ..id = fields[0] as String
      ..taskId = fields[1] as String
      ..notificationTime = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
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
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
