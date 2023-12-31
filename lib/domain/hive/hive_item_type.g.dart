// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_item_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveItemTypeAdapter extends TypeAdapter<HiveItemType> {
  @override
  final int typeId = 0;

  @override
  HiveItemType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveItemType(
      index: fields[0] as int,
      isWatched: fields[1] as bool,
      title: fields[2] as String,
      rate: fields[3] as int,
      createTime: fields[4] as DateTime,
      watchedTime: fields[5] as DateTime,
      comment: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveItemType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.isWatched)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.rate)
      ..writeByte(4)
      ..write(obj.createTime)
      ..writeByte(5)
      ..write(obj.watchedTime)
      ..writeByte(6)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
