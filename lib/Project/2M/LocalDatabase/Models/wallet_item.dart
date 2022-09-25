import 'package:hive/hive.dart';

part 'wallet_item.g.dart';

@HiveType(typeId: 5)
class WalletItem {
  @HiveField(0)
  String iD;

  @HiveField(1)
  String title;

  @HiveField(2)
  String avt;

  @HiveField(3)
  DateTime creWalletDate;

  @HiveField(4, defaultValue: 0.0)
  double moneyWallet;

  WalletItem(
      {this.iD, this.title, this.avt, this.creWalletDate, this.moneyWallet});
}
