import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/recipe.dart';


class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeAdapter());
  }

  static Box<Recipe> getRecipeBox() => Hive.box<Recipe>('recipes');
}
