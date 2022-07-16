import 'package:hive/hive.dart';
part 'category_item.g.dart';

@HiveType(typeId: 2)
class CategoryItem {
  @HiveField(0)
  int iD;

  @HiveField(1)
  String cateName;

  @HiveField(2)
  String cateIcon;

  @HiveField(3)
  String cateType;

  CategoryItem({this.iD, this.cateIcon, this.cateName, this.cateType});
}
