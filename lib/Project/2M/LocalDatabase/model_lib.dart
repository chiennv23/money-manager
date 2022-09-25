library model_lib;

import 'dart:io';

import 'package:coresystem/Core/CacheService.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../Module/Category/DA/category_controller.dart';
import '../Module/Money/DA/money_controller.dart';
import '../Module/Wallet/DA/wallet_controller.dart';
import 'Models/category_item.dart';
import 'Models/money_item.dart';
import 'Models/user_info.dart';
import 'Models/wallet_item.dart';

export 'Models/category_item.dart';
export 'Models/money_item.dart';
export 'Models/user_info.dart';

Uuid uuid = Uuid();

class HiveDB {
  Future initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    print('direction ${appDocDir.path}');
    Hive.registerAdapter(UserItemAdapter());
    Hive.registerAdapter(MoneyItemAdapter());
    Hive.registerAdapter(NoteItemAdapter());
    Hive.registerAdapter(CategoryItemAdapter());
    Hive.registerAdapter(WalletItemAdapter());
    await initDefaultList();
  }

  Future<void> initDefaultList() async {
    final categories = await CacheService.getAll<CategoryItem>();
    final wallets = await CacheService.getAll<WalletItem>();

    if (categories.isEmpty) {
      _categories.forEach((element) {
        element.iD = uuid.v4();
        CacheService.add<CategoryItem>(element.iD, element);
      });
      final categories = await CacheService.getAll<CategoryItem>();
      print('default added cate ${categories.length}');
    } else {
      print('had default cate ${categories.length}');
    }
    if (wallets.isEmpty) {
      _wallets.forEach((element) {
        element.iD = uuid.v4();
        CacheService.add<WalletItem>(element.iD, element);
      });
      final wallets = await CacheService.getAll<WalletItem>();
      print('default added wallet ${wallets.length}');
    } else {
      print('had default wallet ${wallets.length}');
    }
  }
}

class GetControl {
  Future startGetData() async {
    Get.put(CategoryController());
    Get.put(WalletController());
    Get.put(MoneyController());
  }

  Future reStartGetData() async {
    print('restart get data');
    CategoryController cate = Get.find();
    WalletController wallet = Get.find();
    MoneyController money = Get.find();
    cate.onInit();
    wallet.onInit();
    money.onInit();
  }
}

final List<WalletItem> _wallets = [
  WalletItem(
    title: 'Cash',
    creWalletDate: DateTime.now(),
    moneyWallet: 0.0,
    avt: 'lib/Assets/Images/wallet.png',
  )
];

final List<CategoryItem> _categories = [
  // 0: chi tieu
  CategoryItem(
    cateType: '0',
    cateName: 'Ăn uống',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Chi tiêu hàng ngày',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Quần áo',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Siêu thị',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Y tế',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Đi lại',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Tiền điện',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Tiền nhà',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '0',
    cateName: 'Phí điện thoại',
    cateIcon: '',
  ),
  // 1: thu nhap
  CategoryItem(
    cateType: '1',
    cateName: 'Tiền lương',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '1',
    cateName: 'Tiền phụ cấp',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '1',
    cateName: 'Tiền thưởng',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '1',
    cateName: 'Thu thập phụ',
    cateIcon: '',
  ),
  CategoryItem(
    cateType: '1',
    cateName: 'Đầu tư',
    cateIcon: '',
  ),
];
