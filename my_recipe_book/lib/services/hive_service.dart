import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_recipe_book/models/shopping_item.dart';
import 'package:my_recipe_book/models/shopping_lists.dart';
import '../models/recipe.dart';


class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(ShoppingItemAdapter());
    Hive.registerAdapter(ShoppingListAdapter());

  }

  static Box<Recipe> getRecipeBox() => Hive.box<Recipe>('recipes');
  static Box<ShoppingList> getShoppingListBox() => Hive.box<ShoppingList>('shoppingLists');
}
