import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Core/CacheService.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MoneyController extends GetxController {
  WalletController walletController = Get.find();
  final RxList<MoneyItem> _moneyList = <MoneyItem>[].obs;
  static DateTime startD = DateTime.now();
  static DateTime endD = DateTime.now().add(Duration(days: 6));

  // DateTime _selectedValue = obs as DateTime;
  Rx<DateTime> selectedValue = DateTime.now().obs;
  RxString startDateValue = '${startD.day}.${startD.month}'.obs;
  RxString endDateValue = '${endD.day}.${endD.month}.${endD.year}'.obs;

  @override
  void onInit() {
    // deleteAllMoneyNote();
    getMoneyList();
    super.onInit();
  }

  void changeDateShowMoneyList(DateTime startDate, DateTime endDate) {
    startD = startDate;
    endD = endDate;
    print(startD);
    print(endD);
    print(startD.difference(endD).inDays);
    startDateValue.value = '${startDate.day}.${startDate.month}';
    endDateValue.value = '${endDate.day}.${endDate.month}.${endDate.year}';
  }

  List<MoneyItem> get moneyStartEndList {
    print('moneyStartEndList');
    List<MoneyItem> lst = [];
    final numberOfDay = endD.difference(startD).inDays;
    for (var i = 0; i < numberOfDay; i++) {
      final nextDay = DateTime(startD.year, startD.month, startD.day + i);
      final listSameDay =
          _moneyList.where((p0) => p0.creMoneyDate.isSameDate(nextDay));
      lst.addAll(listSameDay);
    }
    return lst;
  }

  double get expenseAllMoneyWallet {
    print('expenseAllMoneyWallet');
    if (_moneyList.length != 0 && _moneyList != null) {
      final double total = moneyStartEndList
          .where((element) => element.moneyType == '0')
          .toList()
          .map((element) => element.moneyValue ?? 0.0)
          .fold(0, (previousValue, element) => previousValue + element);
      return total ?? 0.0;
    } else if (_moneyList.length == 1) {
      return moneyStartEndList
              .firstWhere((element) => element.moneyType == '0',
                  orElse: () => MoneyItem(moneyValue: 0.0))
              .moneyValue ??
          0.0;
    }
    return 0.0;
  }

  // 0: chi tieu
  // 1: thu nhap
  double get incomeAllMoneyWallet {
    print('incomeAllMoneyWallet');
    if (_moneyList.length != 0 && _moneyList != null) {
      final double total = moneyStartEndList
          .where((element) => element.moneyType == '1')
          .toList()
          .map((element) => element.moneyValue ?? 0.0)
          .fold(0, (previousValue, element) => previousValue + element);
      return total ?? 0.0;
    } else if (_moneyList.length == 1) {
      return moneyStartEndList
              .firstWhere((element) => element.moneyType == '1',
                  orElse: () => MoneyItem(moneyValue: 0.0))
              .moneyValue ??
          0.0;
    }
    return 0.0;
  }

  double get totalMoneyWallet {
    print('totalMoneyWallet');
    // final total = _walletList
    //     .map((element) => element.moneyWallet ?? 0.0)
    //     .fold(0, (previousValue, element) => previousValue + element);
    if (incomeAllMoneyWallet >= expenseAllMoneyWallet) {
      final total = incomeAllMoneyWallet - expenseAllMoneyWallet;
      // print(total);
      return total;
    } else {
      return 0.0;
    }
  }

  List<MoneyItem> get top5ExpenseMoneyList {
    print('top5ExpenseMoneyList');
    print('moneyStartEndList + ${moneyStartEndList.length}');
    if (_moneyList.length != 0 && _moneyList != null) {
      final List<MoneyItem> lst = moneyStartEndList
        ..sort((b, a) => a?.moneyValue?.compareTo(b?.moneyValue));
      return lst.where((element) => element.moneyType == '0').take(5).toList();
    } else {
      return [];
    }
  }

  // 0: chi tieu
  // 1: thu nhap
  List<MoneyItem> get top5IncomeMoneyList {
    print('top5IncomeMoneyList');

    if (_moneyList.length != 0 && _moneyList != null) {
      final List<MoneyItem> lst = moneyStartEndList
        ..sort((b, a) => a.moneyValue.compareTo(b.moneyValue));
      var top5List =
          lst.where((element) => element.moneyType == '1').take(5).toList();
      print('lisIncome + ${top5List.length}');
      return top5List;
    } else {
      return [];
    }
  }

  //getAll money
  Future getMoneyList() async {
    final lst = await getAllMoneyNotes();
    _moneyList.assignAll(lst);
  }

  Future<void> addMoneyNote(MoneyItem moneyItem) async {
    print(_moneyList.length);

    if (moneyItem.moneyValue == 0.0) {
      await Get.dialog(
        CupertinoAlertDialog(
          content: Text('Bạn cần nhập số tiền để tiếp tục'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Thoát'),
              onPressed: () => CoreRoutes.instance.pop(),
            )
          ],
        ),
        barrierDismissible: false,
      );
      return;
    }

    // 0: chi tieu
    // 1: thu nhap
    await walletController.addWallet(
        moneyItem.wallet.iD, moneyItem.wallet.title,
        moneyNote: moneyItem.moneyValue.round(),
        expenseType: moneyItem.moneyType == '0',);
    if (_moneyList.any((element) => element.iD == moneyItem.iD)) {
      // edit money
      final indexEditMoney =
          _moneyList.indexWhere((element) => element.iD == moneyItem.iD);
      final editObj =
          _moneyList.firstWhere((element) => element.iD == moneyItem.iD);
      editObj.creMoneyDate = moneyItem.creMoneyDate;
      editObj.noteMoney = moneyItem.noteMoney;
      editObj.wallet = moneyItem.wallet;
      editObj.moneyCateType = moneyItem.moneyCateType;
      editObj.moneyValue = moneyItem.moneyValue;
      await CacheService.edit(indexEditMoney, editObj);
    } else {
      // add money
      //add data to Hive
      await CacheService.add<MoneyItem>(moneyItem.iD, moneyItem);

      _moneyList.add(moneyItem);
    }
    walletController.update();
    _moneyList.refresh();
    print(_moneyList.length);

    await SnackBarCore.success();
  }

  Future<void> deleteMoneyNote(MoneyItem moneyItem) async {
    await CacheService.delete<MoneyItem>(moneyItem.iD);
  }

  Future<void> deleteAllMoneyNote() async {
    await CacheService.clear<MoneyItem>();
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
