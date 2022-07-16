// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryItemAdapter extends TypeAdapter<CategoryItem> {
  @override
  final int typeId = 2;

  @override
  CategoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryItem(
      iD: fields[0] as int,
      cateIcon: fields[2] as String,
      cateName: fields[1] as String,
      cateType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.cateName)
      ..writeByte(2)
      ..write(obj.cateIcon)
      ..writeByte(3)
      ..write(obj.cateType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
