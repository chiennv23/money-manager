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
      final moneyList = _walletList.map((element) => element.moneyWallet);
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
    idWallet.value = index;
    walletChoose.value = _walletList[idWallet.value];
    update();
  }

  String get showNameWallet =>
      '${idWallet != null ? _walletList[idWallet.value].title : _walletList?.first?.title}';

  Future initWalletsList() async {
    final lst = await getAllWallet();
    if (lst != null) {
      _walletList.assignAll(lst);
    }
    if (_walletList != null && _walletList.length != 0) {
      walletChoose.value = _walletList.first;
      // walletChoosenBefore = _walletList.first;
    }
  }

  Future editWalletInMoneyNote(MoneyItem editMoneyItem) async {
    if (_walletList.any((element) =>
        element.iD == editMoneyItem.wallet.iD &&
        element.title == editMoneyItem.wallet.title)) {
      // edit old wallet
      final editWalletObj = _walletList.firstWhere((element) =>
          element.iD == editMoneyItem.wallet.iD &&
          element.title == editMoneyItem.wallet.title);

      // Lấy ví cũ, mới trừ or cộng thêm số tiền mới ở lần chỉnh sửa giao dịch tiền.
      if (walletChoosenBefore?.iD != null &&
          walletChoosenBefore?.iD != walletChoose?.value?.iD) {
        // change money in two wallet
        if (editMoneyItem.moneyType == '0') {
          // chi tieu
          walletChoosenBefore.moneyWallet += editMoneyItem.moneyValue;
          walletChoose.value.moneyWallet -= editMoneyItem.moneyValue;
        } else {
          // thu nhap
          walletChoosenBefore.moneyWallet -= editMoneyItem.moneyValue;
          walletChoose.value.moneyWallet += editMoneyItem.moneyValue;
        }
        await CacheService.edit<WalletItem>(
            walletChoosenBefore.iD, walletChoosenBefore);
        await CacheService.edit<WalletItem>(
            walletChoose.value.iD, walletChoose.value);
      } else {
        // check if quality wallet return
        if (walletChoosenBefore?.iD == walletChoose?.value?.iD) {
          return;
        }
        // add normal money in wallet when add money note
        if (editMoneyItem.moneyType == '0') {
          editWalletObj.moneyWallet -= editMoneyItem.moneyValue;
        } else {
          editWalletObj.moneyWallet += editMoneyItem.moneyValue;
        }
        await CacheService.edit<WalletItem>(editWalletObj.iD, editWalletObj);
      }
      walletChoose.value = _walletList.first;
      walletChoosenBefore = WalletItem();
      final lst = await getAllWallet();
      if (lst != null) {
        _walletList.assignAll(lst);
      }
      _walletList.refresh();
      await SnackBarCore.success();
      update();
      return;
    }
  }

  Future addWallet(
    String id,
    String name,
    String img,
  ) async {
    if (_walletList.length != 0 &&
        _walletList
            .any((element) => element.title == name && element.iD != id)) {
      await SnackBarCore.warning(title: 'Tên Wallet đã tồn tại, hãy thử lại');
      return;
    }

    if (_walletList
        .any((element) => element.iD == id && element.title == name)) {
      // edit old wallet
      final indexEditWallet =
          _walletList.indexWhere((element) => element.iD == id);
      final editWalletObj = _walletList
          .firstWhere((element) => element.iD == id && element.title == name);
      // edit normal wallet
      editWalletObj.title = name;
      editWalletObj.avt = img;
      await CacheService.edit<WalletItem>(editWalletObj.iD, editWalletObj);
      walletChoose.value = _walletList.first;
      _walletList[indexEditWallet] = editWalletObj;
    } else {
      // add new wallet
      final WalletItem obj = WalletItem(
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
    }
    _walletList.refresh();
    CoreRoutes.instance.pop();
    await SnackBarCore.success();
    update();
  }

  Future<List<WalletItem>> getAllWallet() async {
    final rs = await CacheService.getAll<WalletItem>();
    return rs;
  }

  Future<void> deleteThisWallet(String id, String name) async {
    if (moneyController.allMoneyList.any(
        (element) => element.wallet.iD == id && element.wallet.title == name)) {
      await SnackBarCore.warning(title: 'Cannot delete this wallet');
      return;
    }

    await CacheService.delete<WalletItem>(id);
    await SnackBarCore.success();
    _walletList.removeWhere((element) => element.iD == id);
    _walletList.refresh();
  }

  Future<void> delAllWallet() async {
    await CacheService.clear<WalletItem>();
    _walletList.clear();
    update();
  }
}
