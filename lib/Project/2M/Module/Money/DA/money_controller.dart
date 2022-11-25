import 'dart:math';
import 'dart:typed_data';

import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Core/CacheService.dart';
import 'package:coresystem/Core/routes.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/wallet_item.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Wallet/DA/wallet_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MoneyController extends GetxController {
  WalletController walletController = Get.find();
  final RxList<MoneyItem> _moneyList = <MoneyItem>[].obs;
  static final dateNow = DateTime.now();
  static DateTime startD = DateTime(dateNow.year, dateNow.month);
  static DateTime endD =
      DateTime(dateNow.year, dateNow.month + 1).add(Duration(seconds: -1));

  RxList<Uint8List> imgOCR = <Uint8List>[].obs;

  // static DateTime startD = DateTime.now();
  // static DateTime endD = startD.add(Duration(days: 6));
  final RxString walletIdInTab = ''.obs;

  Rx<DateTime> selectedValue = DateTime.now().obs;
  Rx<DateTime> selectedWalletDetailValue = DateTime.now().obs;
  RxString startDateValue = '${startD.day}.${startD.month}'.obs;
  RxString endDateValue = '${endD.day}.${endD.month}.${endD.year}'.obs;
  WalletItem walletItemDetail = WalletItem();

  @override
  void onInit() {
    // deleteAllMoneyNote();
    walletIdInTab.value = '';
    walletItemDetail = WalletItem();
    selectedWalletDetailValue.value = DateTime.now();
    initGetMoneyList();
    super.onInit();
  }

  void changeDateShowMoneyList(DateTime startDate, DateTime endDate) {
    startD = startDate;
    endD = endDate;
    print(startD);
    print(endD);
    print(startD.difference(endD).inDays);
    // startDateValue.value = '${startDate.day}.${startDate.month}';
    // endDateValue.value = '${endDate.day}.${endDate.month}.${endDate.year}';
  }

  void changeWalletIndex(String id) {
    walletIdInTab.value = '';
    walletIdInTab.value = id;
    update();
  }

  List<MoneyItem> get moneyStartEndList {
    List<MoneyItem> lst = [];
    final numberOfDay = endD.difference(startD).inDays + 1;
    for (var i = 0; i < numberOfDay; i++) {
      final nextDay = DateTime(startD.year, startD.month, startD.day + i);
      final listSameDay =
          _moneyList.where((p0) => p0.creMoneyDate.isSameDate(nextDay));
      lst.addAll(listSameDay);
    }
    return lst;
  }

  double get expenseAllMoneyWalletByDates {
    if (_moneyList != null) {
      if (_moneyList.length != 0) {
        final expenseList = walletIdInTab.value == ''
            ? moneyStartEndList
                .where((element) => element.moneyType == '0')
                .toList()
            : moneyStartEndList
                .where((element) =>
                    element.moneyType == '0' &&
                    element.wallet.iD == walletIdInTab.value)
                .toList();
        final double total = expenseList
            .map((element) => element.moneyValue ?? 0.0)
            .fold(0, (previousValue, element) => previousValue + element);
        return total ?? 0.0;
      }
    }
    return 0.0;
  }

  // 0: chi tieu
  // 1: thu nhap
  double get incomeAllMoneyWalletbyDates {
    if (_moneyList != null) {
      if (_moneyList.length != 0) {
        final incomeList = walletIdInTab.value == ''
            ? moneyStartEndList
                .where((element) => element.moneyType == '1')
                .toList()
            : moneyStartEndList
                .where((element) =>
                    element.moneyType == '1' &&
                    element.wallet.iD == walletIdInTab.value)
                .toList();
        final double total = incomeList
            .map((element) => element.moneyValue ?? 0.0)
            .fold(0, (previousValue, element) => previousValue + element);
        return total ?? 0.0;
      }
    }
    return 0.0;
  }

  // dư
  double get surplusMoneyWallet {
    final incomeAllTimeExceptionNowList = walletIdInTab.value == ''
        ? _moneyList
            .where((p0) =>
                p0.moneyType == '1' &&
                !p0.creMoneyDate.isSameMy(selectedValue.value))
            .toList()
        : _moneyList
            .where((p0) =>
                p0.moneyType == '1' &&
                p0.wallet.iD == walletIdInTab.value &&
                !p0.creMoneyDate.isSameMy(selectedValue.value))
            .toList();
    final expenseAllTimeExceptionNowList = walletIdInTab.value == ''
        ? _moneyList
            .where((p0) =>
                p0.moneyType == '0' &&
                !p0.creMoneyDate.isSameMy(selectedValue.value))
            .toList()
        : _moneyList
            .where((p0) =>
                p0.moneyType == '0' &&
                p0.wallet.iD == walletIdInTab.value &&
                !p0.creMoneyDate.isSameMy(selectedValue.value))
            .toList();
    final totalIncomeAllTime = incomeAllTimeExceptionNowList
        .map((e) => e.moneyValue ?? 0.0)
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
    final totalExpenseAllTime = expenseAllTimeExceptionNowList
        .map((e) => e.moneyValue ?? 0.0)
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);
    // if (incomeAllMoneyWallet >= expenseAllMoneyWallet) {
    final total = incomeAllMoneyWalletbyDates - expenseAllMoneyWalletByDates;
    return total + (totalIncomeAllTime - totalExpenseAllTime);
    // } else {
    //   return 0.0;
    // }
  }

  double getHeightChartHome(String type, double totalHeightChart) {
    if (_moneyList.length != 0 && _moneyList != null) {
      final double maxNumber = [
        incomeAllMoneyWalletbyDates,
        expenseAllMoneyWalletByDates,
        surplusMoneyWallet
      ].reduce(max);
      final double minNumber = [
        incomeAllMoneyWalletbyDates,
        expenseAllMoneyWalletByDates,
        surplusMoneyWallet
      ].reduce(min);
      final double sum = maxNumber + minNumber;
      if (type == '0') {
        return expenseAllMoneyWalletByDates == 0.0 || sum <= 0
            ? 0.0
            : expenseAllMoneyWalletByDates / sum * totalHeightChart >=
                    totalHeightChart
                ? totalHeightChart
                : expenseAllMoneyWalletByDates / sum * totalHeightChart;
      } else if (type == '1') {
        return incomeAllMoneyWalletbyDates == 0.0 || sum <= 0
            ? 0.0
            : incomeAllMoneyWalletbyDates / sum * totalHeightChart >=
                    totalHeightChart
                ? totalHeightChart
                : incomeAllMoneyWalletbyDates / sum * totalHeightChart;
      } else {
        return surplusMoneyWallet <= 0.0 || sum <= 0
            ? 0.0
            : surplusMoneyWallet / sum * totalHeightChart >= totalHeightChart
                ? totalHeightChart
                : surplusMoneyWallet / sum * totalHeightChart;
      }
    } else {
      return 0.0;
    }
  }

  List<MoneyItem> get top3ExpenseMoneyList {
    print('top3ExpenseMoneyList');
    print('moneyStartEndList + ${moneyStartEndList.length}');
    if (_moneyList.length != 0 && _moneyList != null) {
      final expenseList = walletIdInTab.value == ''
          ? moneyStartEndList
              .where((element) => element.moneyType == '0')
              .toList()
          : moneyStartEndList
              .where((element) =>
                  element.moneyType == '0' &&
                  element.wallet.iD == walletIdInTab.value)
              .toList();
      final lst = expenseList
        ..sort((b, a) => a.moneyValue.compareTo(b.moneyValue));
      return lst.take(3).toList();
    } else {
      return [];
    }
  }

  List<MoneyItem> get AllExpenseMoneyByDateList {
    print('AllExpenseMoneyList');
    if (_moneyList.length != 0 && _moneyList != null) {
      final expenseList = walletIdInTab.value == ''
          ? _moneyList
              .where((element) =>
                  element.moneyType == '0' &&
                  element.creMoneyDate
                      .isSameMy(moneyController.selectedValue.value))
              .toList()
          : _moneyList
              .where((element) =>
                  element.moneyType == '0' &&
                  element.creMoneyDate
                      .isSameMy(moneyController.selectedValue.value) &&
                  element.wallet.iD == walletIdInTab.value)
              .toList();

      return expenseList;
    } else {
      return [];
    }
  }

  // -----------------------------------------------------------------------------
  // Chức năng trong wallet detail

  double get expenseAllMoneyWalletDetail {
    if (_moneyList.length != 0 && _moneyList != null) {
      final expenseList = moneyListPageView
          .where((element) =>
              element.moneyType == '0' &&
              element.wallet.iD == walletItemDetail.iD)
          .toList();
      final double total = expenseList
          .map((element) => element.moneyValue ?? 0.0)
          .fold(0, (previousValue, element) => previousValue + element);
      return total ?? 0.0;
    }
    return 0.0;
  }

  // 0: chi tieu
  // 1: thu nhap
  double get incomeAllMoneyWalletDetail {
    if (_moneyList.length != 0 && _moneyList != null) {
      final incomeList = moneyListPageView
          .where((element) =>
              element.moneyType == '1' &&
              element.wallet.iD == walletItemDetail.iD)
          .toList();
      final double total = incomeList
          .where((element) => element.moneyType == '1')
          .toList()
          .map((element) => element.moneyValue ?? 0.0)
          .fold(0, (previousValue, element) => previousValue + element);
      return total ?? 0.0;
    }
    return 0.0;
  }

  // dư
  double get surplusMoneyWalletDetail {
    // if (incomeAllMoneyWallet >= expenseAllMoneyWallet) {
    final total = incomeAllMoneyWalletDetail - expenseAllMoneyWalletDetail;
    return total;
    // } else {
    //   return 0.0;
    // }
  }

  List<MoneyItem> get moneyListPageView {
    if (_moneyList.length != 0 && _moneyList != null) {
      List<MoneyItem> lst = [];
      final listSameDay = _moneyList
          .where((p0) =>
              p0.creMoneyDate.month == selectedWalletDetailValue.value.month &&
              p0.creMoneyDate.year == selectedWalletDetailValue.value.year &&
              p0.wallet.iD == walletItemDetail.iD)
          .toList();
      lst.addAll(listSameDay);
      return lst;
    } else {
      return [];
    }
  }

  void changeDateTimeWalletDetail(String status) {
    // change dateTime show money list
    if (status == 'plus') {
      int year = selectedWalletDetailValue.value.year;
      int month = selectedWalletDetailValue.value.month;
      month++;
      if (selectedWalletDetailValue.value.month > 12) {
        year++;
      }
      selectedWalletDetailValue.value = DateTime(year, month);
    } else {
      int year = selectedWalletDetailValue.value.year;
      int month = selectedWalletDetailValue.value.month;
      month--;
      if (selectedWalletDetailValue.value.month < 1) {
        year--;
      }
      selectedWalletDetailValue.value = DateTime(year, month);
    }
  }

  // 0: chi tieu
  // 1: thu nhap
  // List<MoneyItem> get top5IncomeMoneyList {
  //   print('top5IncomeMoneyList');
  //
  //   if (_moneyList.length != 0 && _moneyList != null) {
  //     final incomeList = _walletIdInTab.value == ''
  //         ? moneyStartEndList
  //             .where((element) => element.moneyType == '1')
  //             .toList()
  //         : moneyStartEndList
  //             .where((element) =>
  //                 element.moneyType == '1' &&
  //                 element.wallet.iD == _walletIdInTab.value)
  //             .toList();
  //     final List<MoneyItem> lst = incomeList
  //       ..sort((b, a) => a.moneyValue.compareTo(b.moneyValue));
  //     var top5List = lst.take(5).toList();
  //     print('lisIncome + ${top5List.length}');
  //     return top5List;
  //   } else {
  //     return [];
  //   }
  // }

  //getAll money
  Future initGetMoneyList() async {
    final lst = await getAllMoneyNotes();
    if (lst != null) {
      _moneyList.assignAll(lst);
    }
  }

  List<MoneyItem> get allMoneyList => _moneyList;

  Future<void> addMoneyNote(MoneyItem moneyItem) async {
    if (moneyItem.moneyValue == 0.0 || moneyItem.wallet.iD == null) {
      await Get.dialog(
        CupertinoAlertDialog(
          content: Text(moneyItem.wallet.iD == null
              ? 'You need to add wallet to continue'
              : 'You need to enter the amount to continue'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () => CoreRoutes.instance.pop(),
            )
          ],
        ),
        barrierDismissible: false,
      );
      return;
    }
    // if same data no edit anything
    if (_moneyList.any((element) => element.iD == moneyItem.iD)) {
      final editObj =
          _moneyList.firstWhere((element) => element.iD == moneyItem.iD);
      if (editObj.moneyValue == moneyItem.moneyValue &&
          editObj.creMoneyDate.isSameDate(moneyItem.creMoneyDate) &&
          editObj.noteMoney.iD == moneyItem.noteMoney.iD &&
          editObj.wallet.iD == moneyItem.wallet.iD &&
          editObj.moneyCateType.iD == moneyItem.moneyCateType.iD) {
        CoreRoutes.instance.pop();
        return;
      }
    }
    // 0: chi tieu
    // 1: thu nhap
    if (_moneyList.any((element) => element.iD == moneyItem.iD)) {
      // edit money
      final editObj =
          _moneyList.firstWhere((element) => element.iD == moneyItem.iD);
      editObj.creMoneyDate = moneyItem.creMoneyDate;
      editObj.noteMoney = moneyItem.noteMoney;
      editObj.wallet = moneyItem.wallet;
      editObj.moneyCateType = moneyItem.moneyCateType;
      editObj.moneyValue = moneyItem.moneyValue;
      await CacheService.edit(moneyItem.iD, editObj);
      CoreRoutes.instance.pop(result: true);
    } else {
      // add money
      //add data to Hive
      await CacheService.add<MoneyItem>(moneyItem.iD, moneyItem);

      _moneyList.add(moneyItem);
    }
    await initGetMoneyList();
    _moneyList.refresh();
    await walletController.initTotalMoneyEachWallet(moneyList: _moneyList);

    await SnackBarCore.success();
  }

  Future<void> deleteMoneyNote(MoneyItem moneyItem) async {
    await CacheService.delete<MoneyItem>(moneyItem.iD);
    _moneyList.removeWhere((element) => element.iD == moneyItem.iD);
    _moneyList.refresh();
    await walletController.initTotalMoneyEachWallet(moneyList: _moneyList);
    await SnackBarCore.success(title: 'Deleted ${moneyItem.moneyCateType.cateName} on ${FDate.dMy(moneyItem.creMoneyDate)}');

  }

  Future<void> deleteAllMoneyNote() async {
    await CacheService.clear<MoneyItem>();
    _moneyList.clear();
    update();
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
