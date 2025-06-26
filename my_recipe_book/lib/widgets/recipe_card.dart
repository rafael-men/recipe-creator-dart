import 'dart:io';

import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: ListTile(
        leading: recipe.photoPath.isNotEmpty
            ? Image.file(
                File(recipe.photoPath),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.restaurant_menu),
        title: Text(recipe.name),
        subtitle: Text(
            '${recipe.originCountry} • ${recipe.difficulty} • ${recipe.preparationTime} min'),
      ),
    );
  }
}
