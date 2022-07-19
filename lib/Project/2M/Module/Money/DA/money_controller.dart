import 'package:coresystem/Core/CacheService.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';

class MoneyController {
  Future<void> addMoneyNote(MoneyItem moneyItem) async {
    await CacheService.add<MoneyItem>(moneyItem.iD, moneyItem);
  }

  Future<void> deleteMoneyNote(MoneyItem moneyItem) async {
    await CacheService.delete<MoneyItem>(moneyItem.iD);
  }

  Future<MoneyItem> getMoneyNote(String iD) async {
    final rs = await CacheService.getByKey<MoneyItem>(iD);
    return rs;
  }

  Future<List<MoneyItem>> getAllMoneyNotes() async {
    final rs = await CacheService.getAll<MoneyItem>();
    return rs;
  }
}
