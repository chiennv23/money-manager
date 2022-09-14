// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyItemAdapter extends TypeAdapter<MoneyItem> {
  @override
  final int typeId = 3;

  @override
  MoneyItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyItem(
      iD: fields[0] as String,
      creMoneyDate: fields[4] as DateTime,
      moneyCateType: fields[3] as CategoryItem,
      moneyType: fields[1] as String,
      noteMoney: fields[5] as NoteItem,
      moneyValue: fields[2] as double,
      wallet: fields[6] as WalletItem,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.moneyType)
      ..writeByte(2)
      ..write(obj.moneyValue)
      ..writeByte(3)
      ..write(obj.moneyCateType)
      ..writeByte(4)
      ..write(obj.creMoneyDate)
      ..writeByte(5)
      ..write(obj.noteMoney)
      ..writeByte(6)
      ..write(obj.wallet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteItemAdapter extends TypeAdapter<NoteItem> {
  @override
  final int typeId = 4;

  @override
  NoteItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteItem(
      iD: fields[0] as String,
      noteImg: (fields[2] as List)?.cast<File>(),
      noteValue: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.noteValue)
      ..writeByte(2)
      ..write(obj.noteImg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
