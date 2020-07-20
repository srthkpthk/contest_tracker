// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContestEntityAdapter extends TypeAdapter<ContestEntity> {
  @override
  final typeId = 0;

  @override
  ContestEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContestEntity(
      (fields[0] as List)?.cast<Objects>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContestEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.objects);
  }
}
