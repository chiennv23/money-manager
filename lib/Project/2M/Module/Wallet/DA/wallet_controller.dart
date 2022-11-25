import 'package:coresystem/Project/2M/LocalDatabase/Models/wallet_item.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:coresystem/Project/2M/Module/Category/DA/category_controller.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:get/get.dart';

import '../../../../../Components/widgets/SnackBar.dart';
import '../../../../../Core/CacheService.dart';
import '../../../../../Core/routes.dart';

MoneyController moneyController = Get.find();

class WalletController extends GetxController {
  final RxList<WalletItem> _walletList = <WalletItem>[].obs;
  Rx<WalletItem> walletChoose = WalletItem().obs;

  // save wallet before when edit money note
  WalletItem walletChoosenBefore = WalletItem();

  RxInt idWallet = 0.obs;

  @override
  void onInit() {
    // delAllWallet();
    idWallet.value = 0;
    walletChoosenBefore = WalletItem();
    walletChoose.value = WalletItem();
    initWalletsList();
    super.onInit();
  }

  double get totalMoneyInWallets {
    print('totalMoneyInWallets');
    if (_walletList != null && _walletList.length != 0) {
      final moneyList = moneyController.allMoneyList
          .map((element) => element.wallet.moneyWallet);
      final total = moneyList.reduce((a, b) => a + b);
      return total;
    } else {
      return 0.0;
    }
  }

  // get category list
  List<WalletItem> get walletList {
    return _walletList;
  }

  // get index UI cate
  void getIndex(int index) {
    if (_walletList.isNotEmpty) {
      idWallet.value = index;
      walletChoose.value = _walletList[index];
    }

    update();
  }

  String get showNameWallet =>
      '${idWallet != null ? _walletList[idWallet.value].title : _walletList?.first?.title}';

  Future initWalletsList() async {
    final lst = await getAllWallet();
    if (lst != null) {
      _walletList.assignAll(lst);
    }
    if (_walletList != null && _walletList.isNotEmpty) {
      walletChoose.value = _walletList.first;
      // walletChoosenBefore = _walletList.first;
    }
  }

  Future initTotalMoneyEachWallet({List<MoneyItem> moneyList}) async {
    if (moneyList != null && moneyList.isNotEmpty) {
      // 0: chi tieu
      // 1: thu nhap
      _walletList.forEach((walletItem) {
        final totalExpense = moneyList
            .where((element) =>
                element.moneyType == '0' && element.wallet.iD == walletItem.iD)
            .toList()
            .map((e) => e.moneyValue ?? 0.0)
            .fold(0, (previousValue, element) => previousValue + element);

        final totalIncome = moneyList
            .where((element) =>
                element.moneyType == '1' && element.wallet.iD == walletItem.iD)
            .toList()
            .map((e) => e.moneyValue ?? 0.0)
            .fold(0, (previousValue, element) => previousValue + element);

        final indexOfWallet =
            _walletList.indexWhere((element) => element.iD == walletItem.iD);
        final obj = _walletList[indexOfWallet];
        obj.moneyWallet = (totalIncome - totalExpense).toDouble();
        _walletList[indexOfWallet] = obj;
      });
    }
    _walletList.refresh();
  }

  // Future editWalletInMoneyNote(MoneyItem editMoneyItem) async {
  //   if (_walletList.any((element) =>
  //       element.iD == editMoneyItem.wallet.iD &&
  //       element.title == editMoneyItem.wallet.title)) {
  //     // edit old wallet
  //     final editWalletObj = _walletList.firstWhere((element) =>
  //         element.iD == editMoneyItem.wallet.iD &&
  //         element.title == editMoneyItem.wallet.title);
  //     final moneyChooseBefore = moneyController.allMoneyList
  //         .firstWhere((element) => element.iD == editMoneyItem.iD);
  //
  //     // Lấy ví cũ, mới trừ or cộng thêm số tiền mới ở lần chỉnh sửa giao dịch tiền.
  //     if (walletChoosenBefore?.iD != null &&
  //         walletChoosenBefore?.iD != walletChoose?.value?.iD) {
  //       // change money in two wallet
  //       if (editMoneyItem.moneyType == '0') {
  //         // chi tieu
  //         walletChoosenBefore.moneyWallet += editMoneyItem.moneyValue;
  //         walletChoose.value.moneyWallet -= editMoneyItem.moneyValue;
  //       } else {
  //         // thu nhap
  //         walletChoosenBefore.moneyWallet -= editMoneyItem.moneyValue;
  //         walletChoose.value.moneyWallet += editMoneyItem.moneyValue;
  //       }
  //       await CacheService.edit<WalletItem>(
  //           walletChoosenBefore.iD, walletChoosenBefore);
  //       await CacheService.edit<WalletItem>(
  //           walletChoose.value.iD, walletChoose.value);
  //     } else {
  //       // check if quality wallet return
  //       if (walletChoosenBefore?.iD == walletChoose?.value?.iD &&
  //           moneyChooseBefore.moneyValue == editMoneyItem.moneyValue) {
  //         return;
  //       }
  //       final moneyChanged =
  //           moneyChooseBefore.moneyValue == editMoneyItem.moneyValue
  //               ? editMoneyItem.moneyValue
  //               : (editMoneyItem.moneyValue -= moneyChooseBefore.moneyValue);
  //       // add normal money in wallet when add money note
  //       if (editMoneyItem.moneyType == '0') {
  //         // editWalletObj.moneyWallet +=
  //         editWalletObj.moneyWallet -= moneyChanged;
  //       } else {
  //         editWalletObj.moneyWallet += editMoneyItem.moneyValue;
  //       }
  //       await CacheService.edit<WalletItem>(editWalletObj.iD, editWalletObj);
  //     }
  //     walletChoose.value = _walletList.first;
  //     walletChoosenBefore = WalletItem();
  //     final lst = await getAllWallet();
  //     if (lst != null) {
  //       _walletList.assignAll(lst);
  //     }
  //     _walletList.refresh();
  //     await SnackBarCore.success();
  //     update();
  //     return;
  //   }
  // }

  Future addWallet(
    String id,
    String name,
    String img,
  ) async {
    if (_walletList.isNotEmpty &&
        _walletList.any((element) =>
            element.title.toLowerCase() == name.toLowerCase() &&
            element.iD != id)) {
      await SnackBarCore.warning(title: 'Wallet name already exists, try again');
      return;
    }

    if (_walletList
        .any((element) => element.iD == id && element.title == name)) {
      // edit old wallet
      final indexEditWallet =
          _walletList.indexWhere((element) => element.iD == id);
      final editWalletObj = _walletList
          .firstWhere((element) => element.iD == id && element.title == name);
      editWalletObj.title = name;
      editWalletObj.avt = img;
      await CacheService.edit<WalletItem>(editWalletObj.iD, editWalletObj);
      _walletList[indexEditWallet] = editWalletObj;
      CoreRoutes.instance.pop(result: editWalletObj);
    } else {
      // add new wallet
      final obj = WalletItem(
        iD: id,
        title: name,
        avt: img,
        moneyWallet: 0.0,
        creWalletDate: DateTime.now(),
      );
      await CacheService.add<WalletItem>(id, obj);
      _walletList.add(obj);
      idWallet.value = _walletList.indexWhere((element) => element.iD == id);
      walletChoose.value = _walletList[idWallet.value];
      CoreRoutes.instance.pop(result: obj);
    }
    await initWalletsList();
    _walletList.refresh();
    await initTotalMoneyEachWallet(moneyList: moneyController.allMoneyList);
    await SnackBarCore.success();
  }

  Future<List<WalletItem>> getAllWallet() async {
    final rs = await CacheService.getAll<WalletItem>();
    return rs;
  }

  Future<void> deleteThisWallet(String id, String name) async {
    if (walletList.length == 1) {
      await SnackBarCore.warning(title: 'Cannot delete when have one wallet');
      return;
    }
    if (moneyController.allMoneyList.any(
        (element) => element.wallet.iD == id && element.wallet.title == name)) {
      await SnackBarCore.warning(title: 'Cannot delete this wallet');
      return;
    }

    await CacheService.delete<WalletItem>(id);
    await SnackBarCore.success(title: 'Deleted "$name" wallet successful!');
    _walletList.removeWhere((element) => element.iD == id);
    _walletList.refresh();
  }

  Future<void> delAllWallet() async {
    await CacheService.clear<WalletItem>();
    _walletList.clear();
    update();
  }
}
