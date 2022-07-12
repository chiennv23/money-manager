import 'package:hive_flutter/hive_flutter.dart';
// part 'UserItem.g.dart';

@HiveType(typeId: 0)
class UserItem {
  @HiveField(0)
  String fullName;

  @HiveField(1)
  int age;

  @HiveField(2)
  DateTime dateTime;
  //
  // @HiveField(3)
  // List<CareerItem> careers = [];

  @HiveField(4)
  String address;

  @HiveField(5)
  double avgIncomeMonth;

  UserItem(
      {this.fullName,
      this.age,
      this.dateTime,
      // this.careers,
      this.address,
      this.avgIncomeMonth});
}

class CareerItem {
  String careerName;
  int careerId;

  CareerItem({this.careerId, this.careerName});
}
