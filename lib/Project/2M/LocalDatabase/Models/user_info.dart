import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'user_info.g.dart';

@HiveType(typeId: 0)
class UserItem {
  @HiveField(0)
  String fullName;

  @HiveField(1)
  int age;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(4)
  String address;

  @HiveField(5)
  double avgIncomeMonth;

  @HiveField(6)
  String iD;

  UserItem(
      {this.fullName,
      this.age,
      this.iD,
      this.dateTime,
      this.address,
      this.avgIncomeMonth}) ;
}
