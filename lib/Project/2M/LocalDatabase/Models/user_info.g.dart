// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserItemAdapter extends TypeAdapter<UserItem> {
  @override
  final int typeId = 0;

  @override
  UserItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserItem(
      fullName: fields[0] as String,
      age: fields[1] as int,
      iD: fields[6] as String,
      dateTime: fields[2] as DateTime,
      address: fields[4] as String,
      avgIncomeMonth: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.avgIncomeMonth)
      ..writeByte(6)
      ..write(obj.iD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
