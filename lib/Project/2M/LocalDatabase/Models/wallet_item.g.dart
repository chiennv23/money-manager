// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletItemAdapter extends TypeAdapter<WalletItem> {
  @override
  final int typeId = 5;

  @override
  WalletItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletItem(
      iD: fields[0] as String,
      title: fields[1] as String,
      avt: fields[2] as String,
      creWalletDate: fields[3] as DateTime,
      moneyWallet: fields[4] == null ? 0.0 : fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WalletItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.avt)
      ..writeByte(3)
      ..write(obj.creWalletDate)
      ..writeByte(4)
      ..write(obj.moneyWallet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
