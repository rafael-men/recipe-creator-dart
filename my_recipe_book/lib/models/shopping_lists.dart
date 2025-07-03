import 'package:hive/hive.dart';
import 'package:my_recipe_book/models/shopping_item.dart';


part 'shopping_lists.g.dart';

@HiveType(typeId: 3)
class ShoppingList extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  List<ShoppingItem> items;

  ShoppingList({required this.title, required this.items});
}
