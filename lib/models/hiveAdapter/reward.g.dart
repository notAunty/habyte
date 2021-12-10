// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reward.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RewardAdapter extends TypeAdapter<Reward> {
  @override
  final int typeId = 1;

  @override
  Reward read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reward()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..points = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Reward obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RewardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
