import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String originCountry;

  @HiveField(2)
  int preparationTime;

  @HiveField(3)
  List<String> ingredients;

  @HiveField(4)
  String preparationMethod;

  @HiveField(5)
  String difficulty; 

  @HiveField(6)
  String photoPath;

  @HiveField(7)
  String recipeType; 

  Recipe({
    required this.name,
    required this.originCountry,
    required this.preparationTime,
    required this.ingredients,
    required this.preparationMethod,
    required this.difficulty,
    required this.photoPath,
    required this.recipeType,
  });
}
