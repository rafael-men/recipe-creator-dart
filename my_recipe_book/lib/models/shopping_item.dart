import 'package:hive/hive.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 2)
class ShoppingItem {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isChecked;

  ShoppingItem({required this.name, this.isChecked = false});
}
