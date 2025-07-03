import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import '../constants/oriental_countries.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? originCountry;
  String? difficulty;
  List<String>? ingredients;
  String? instructions;
  int? preparationTime;
  String recipeType = 'tradicional';
  File? imageFile;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void saveRecipe() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final recipe = Recipe(
      name: name!,
      originCountry: originCountry!,
      difficulty: difficulty!,
      ingredients: ingredients!,
      preparationMethod: instructions!,
      preparationTime: preparationTime!,
      photoPath: imageFile?.path ?? '',
      recipeType: recipeType,
    );

    final box = Hive.box<Recipe>('recipes');
    await box.add(recipe);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receita criada com sucesso')),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Receita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: imageFile == null
                    ? Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.add_a_photo)),
                      )
                    : Image.file(imageFile!,
                        height: 150, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome da Receita'),
                validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                onSaved: (value) => name = value,
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'País de Origem'),
                items: ([
                  'Brasil',
                  'México',
                  'Argentina',
                  'Chile',
                  'Peru',
                  'Colômbia',
                  'Uruguai',
                  'Venezuela',
                  'Equador',
                  'Bolívia',
                  'Paraguai',
                  'Cuba',
                  'Itália',
                  'França',
                  'Espanha',
                  'Portugal',
                  'Alemanha',
                  'Grécia',
                  'Suíça',
                  'Reino Unido',
                  'Irlanda',
                  'Holanda',
                  'Bélgica',
                  'Suécia',
                  'Noruega',
                  'Dinamarca',
                  'Áustria',
                  'Hungria',
                  'Polônia',
                  'República Tcheca',
                  'Croácia',
                  'Marrocos',
                  'Síria', 
                  'Armênia',
                  ...orientalCountries,
                ]).map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    originCountry = value;
                    recipeType = orientalCountries.contains(value)
                        ? 'oriental'
                        : 'tradicional';
                  });
                },
                validator: (value) => value == null ? 'Selecione um país' : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Tempo de preparo (minutos)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                onSaved: (value) => preparationTime = int.tryParse(value!),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Dificuldade'),
                items: ['Fácil', 'Médio', 'Difícil'].map((d) {
                  return DropdownMenuItem(value: d, child: Text(d));
                }).toList(),
                validator: (value) =>
                    value == null ? 'Selecione a dificuldade' : null,
                onChanged: (value) => difficulty = value,
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Ingredientes'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                onSaved: (value) =>
                    ingredients = value!.split(',').map((e) => e.trim()).toList(),
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Modo de preparo'),
                maxLines: 4,
                validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                onSaved: (value) => instructions = value,
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: saveRecipe,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Receita'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}