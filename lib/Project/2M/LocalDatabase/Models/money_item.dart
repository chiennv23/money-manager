import 'dart:io';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import 'category_item.dart';
import 'wallet_item.dart';

part 'money_item.g.dart';

@HiveType(typeId: 3)
class MoneyItem {
  @HiveField(0)
  String iD;

  @HiveField(1)
  String moneyType;

  @HiveField(2)
  double moneyValue;

  @HiveField(3)
  CategoryItem moneyCateType;

  @HiveField(4)
  DateTime creMoneyDate;

  @HiveField(5)
  NoteItem noteMoney;

  @HiveField(6)
  WalletItem wallet;

  MoneyItem(
      {this.iD,
      this.creMoneyDate,
      this.moneyCateType,
      this.moneyType,
      this.noteMoney,
      this.moneyValue,
      this.wallet});
}

@HiveType(typeId: 4)
class NoteItem {
  @HiveField(0)
  String iD;

  @HiveField(1)
  String noteValue;

  @HiveField(2)
  List<Uint8List> noteImg;

  NoteItem({this.iD, this.noteImg, this.noteValue});
}
