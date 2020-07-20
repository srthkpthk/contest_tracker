// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObjectsAdapter extends TypeAdapter<Objects> {
  @override
  final typeId = 1;

  @override
  Objects read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Objects(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as Resource,
      fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Objects obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.event)
      ..writeByte(3)
      ..write(obj.href)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.resource)
      ..writeByte(6)
      ..write(obj.start);
  }
}
