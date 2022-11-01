import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Project/2M/LocalDatabase/model_lib.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../../Core/CacheService.dart';
import '../../../../../Core/routes.dart';

class CategoryController extends GetxController {
  // 0: chi tieu
  // 1: thu nhap
  final RxList<CategoryItem> _cateList = <CategoryItem>[].obs;
  RxInt idCate = 0.obs;
  RxInt idCateType = 0.obs;
  CategoryItem cateChoose = CategoryItem();

  @override
  void onInit() {
    // deleteAllCategory();
    idCate.value = 0;
    cateChoose = CategoryItem();
    getCateList();
    super.onInit();
  }

  // get all category list
  List<CategoryItem> get allCateList => _cateList;

  // get category list
  List<CategoryItem> get cateByTypeList {
    return _cateList
        .where((element) => element.cateType == idCateType.value.toString())
        .toList();
  }

  // get index Type cate
  int getTypeCate(int index) => idCateType.value = index;

  // get index UI cate
  void getIndex(int index) {
    idCate.value = index;
    cateChoose = cateByTypeList[idCate.value];
  }

  String get showNameCate =>
      '${idCate.value > 0 ? cateByTypeList[idCate.value].cateName : cateByTypeList?.first?.cateName}';

  Future getCateList() async {
    final lst = await getAllCategory();
    if (lst != null) {
      _cateList.assignAll(lst);
    }
    if (_cateList != null && _cateList.length != 0) {
      cateChoose = _cateList.first;
    }
  }

  Future<void> addCategory(
      String id, String name, String icon, int idType) async {
    // 0: chi tieu
    // 1: thu nhap
    if (_cateList.any((element) =>
        element.cateName.trim().toLowerCase() == name.trim().toLowerCase() &&
        element.iD != id)) {
      await SnackBarCore.warning(title: 'Trùng tên danh mục, hãy thử lại');
      return;
    }
    if (_cateList.any((element) => element.iD == id)) {
      // check no edit anything
      final editCate = _cateList.firstWhere((element) => element.iD == id);
      final indexEditCate = _cateList.indexWhere((element) => element.iD == id);
      if (editCate.cateName == name && editCate.cateIcon == icon) {
        CoreRoutes.instance.pop();
        return;
      }
      // edit
      editCate.cateIcon = icon;
      editCate.cateName = name;
      editCate.cateType = idType.toString();
      await CacheService.edit<CategoryItem>(id, editCate);
      _cateList[indexEditCate] = editCate;
      _cateList.refresh();
      CoreRoutes.instance.pop();
      await SnackBarCore.success();
      return;
    }
    final obj = CategoryItem(
        iD: id, cateName: name, cateType: idType.toString(), cateIcon: icon);
    await CacheService.add<CategoryItem>(id, obj);
    _cateList.insert(0, obj);
    _cateList.refresh();
    idCate.value = _cateList.indexWhere((element) => element.iD == obj.iD);
    cateChoose = _cateList.first;
    CoreRoutes.instance.pop(result: idCate.value);
    await SnackBarCore.success();
  }

  Future<void> deleteCategory(CategoryItem categoryItem) async {
    await CacheService.delete<CategoryItem>(categoryItem.iD);
    _cateList.removeWhere((element) => element.iD == categoryItem.iD);
    _cateList.refresh();
  }

  Future<void> deleteAllCategory() async {
    await CacheService.clear<CategoryItem>();
    _cateList.clear();
    update();
  }

  Future<CategoryItem> getCategory(String iD) async {
    final rs = await CacheService.getByKey<CategoryItem>(iD);
    return rs;
  }

  Future<List<CategoryItem>> getAllCategory() async {
    final rs = await CacheService.getAll<CategoryItem>();
    return rs;
  }
}
