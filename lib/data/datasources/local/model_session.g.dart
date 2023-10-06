// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatodbsessionAdapter extends TypeAdapter<Dato_db_session> {
  @override
  final int typeId = 1;

  @override
  Dato_db_session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dato_db_session(
      id: fields[0] as int?,
      username: fields[1] as String?,
      tSeconds: fields[2] as int,
      score: fields[3] as int,
      difficultyLevel: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Dato_db_session obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.tSeconds)
      ..writeByte(3)
      ..write(obj.score)
      ..writeByte(4)
      ..write(obj.difficultyLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatodbsessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
