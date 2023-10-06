// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatodbAdapter extends TypeAdapter<Dato_db> {
  @override
  final int typeId = 0;

  @override
  Dato_db read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dato_db(
      id: fields[0] as int?,
      username: fields[1] as String,
      birthDate: fields[2] as String,
      grade: fields[3] as int,
      school: fields[4] as String,
      difficultyLevel: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Dato_db obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.birthDate)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(4)
      ..write(obj.school)
      ..writeByte(5)
      ..write(obj.difficultyLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatodbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
