// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveModelAdapter extends TypeAdapter<SaveModel> {
  @override
  final int typeId = 0;

  @override
  SaveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveModel(
      author: fields[4] as String?,
      title: fields[0] as String,
      description: fields[1] as String,
      image: fields[3] as String?,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
