import 'dart:io';
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: const Color(0xFF8B0000),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          recipe.photoPath.isNotEmpty && File(recipe.photoPath).existsSync()
              ? Image.file(File(recipe.photoPath), height: 200, fit: BoxFit.cover)
              : const SizedBox(height: 200, child: Icon(Icons.image, size: 100)),

          const SizedBox(height: 16),

          Text(
            'Origem: ${recipe.originCountry}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Dificuldade: ${recipe.difficulty}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Tempo de preparo: ${recipe.preparationTime} minutos',
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 16),

          const Text('Ingredientes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ...recipe.ingredients.map((item) => Text('• $item')),

          const SizedBox(height: 16),

          const Text('Modo de preparo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(recipe.preparationMethod),
        ],
      ),
    );
  }
}
