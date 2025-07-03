import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import '../pages/edit_recipe_page.dart';
import '../pages/recipe_detail_page.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  void _deleteRecipe(BuildContext context) async {
    final box = Hive.box<Recipe>('recipes');
    final key = recipe.key;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir esta receita?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await box.delete(key);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receita excluída')),
      );
    }
  }

  void _editRecipe(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditRecipePage(recipe: recipe),
      ),
    );
  }

  void _openDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailPage(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetails(context),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.photoPath.isNotEmpty && File(recipe.photoPath).existsSync())
              Image.file(
                File(recipe.photoPath),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 180,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.image, size: 60, color: Colors.grey)),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${recipe.originCountry} • ${recipe.difficulty} • ${recipe.preparationTime} min',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => _editRecipe(context),
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: 'Editar',
                      ),
                      IconButton(
                        onPressed: () => _deleteRecipe(context),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Excluir',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
