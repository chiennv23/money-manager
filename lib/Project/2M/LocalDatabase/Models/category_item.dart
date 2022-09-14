import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'category_item.g.dart';

@HiveType(typeId: 2)
class CategoryItem {
  @HiveField(0)
  String iD;

  @HiveField(1)
  String cateName;

  @HiveField(2)
  String cateIcon;

  @HiveField(3)
  String cateType;

  CategoryItem({this.iD, this.cateIcon, this.cateName, this.cateType});
}
