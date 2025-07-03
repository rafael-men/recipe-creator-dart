import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import '../constants/oriental_countries.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({super.key, required this.recipe});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String originCountry;
  late String difficulty;
  late List<String> ingredients;
  late String instructions;
  late int preparationTime;
  late String recipeType;
  File? imageFile;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final r = widget.recipe;
    name = r.name;
    originCountry = r.originCountry;
    difficulty = r.difficulty;
    ingredients = r.ingredients;
    instructions = r.preparationMethod;
    preparationTime = r.preparationTime;
    recipeType = r.recipeType;
    if (r.photoPath.isNotEmpty && File(r.photoPath).existsSync()) {
      imageFile = File(r.photoPath);
    }
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void saveEdits() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final updatedRecipe = widget.recipe
      ..name = name
      ..originCountry = originCountry
      ..difficulty = difficulty
      ..ingredients = ingredients
      ..preparationMethod = instructions
      ..preparationTime = preparationTime
      ..photoPath = imageFile?.path ?? ''
      ..recipeType = orientalCountries.contains(originCountry)
          ? 'oriental'
          : 'tradicional';

    await updatedRecipe.save();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receita atualizada com sucesso')),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Receita'),
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
                    : Image.file(imageFile!, height: 150, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),


              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Nome da Receita'),
                validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                onSaved: (value) => name = value!,
              ),

              const SizedBox(height: 16),


              DropdownButtonFormField<String>(
                value: originCountry,
                decoration: const InputDecoration(labelText: 'País de Origem'),
                items: ([

                  'Brasil', 'México', 'Argentina', 'Chile', 'Peru', 'Colômbia', 'Uruguai', 'Venezuela',
                  'Equador', 'Bolívia', 'Paraguai', 'Cuba',
                  'Itália', 'França', 'Espanha', 'Portugal', 'Alemanha', 'Grécia', 'Suíça', 'Reino Unido',
                  'Irlanda', 'Holanda', 'Bélgica', 'Suécia', 'Noruega', 'Dinamarca', 'Áustria', 'Hungria',
                  'Polônia', 'República Tcheca', 'Croácia',
                  'Cajun', 'Marrocos', 'Síria', 'Armênia',
                  ...orientalCountries,
                ]).map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    originCountry = value!;
                    recipeType = orientalCountries.contains(originCountry)
                        ? 'oriental'
                        : 'tradicional';
                  });
                },
              ),

              const SizedBox(height: 16),

              // Tempo de preparo
              TextFormField(
                initialValue: preparationTime.toString(),
                decoration: const InputDecoration(labelText: 'Tempo de preparo (minutos)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => preparationTime = int.tryParse(value!) ?? 0,
              ),

              const SizedBox(height: 16),

      
              DropdownButtonFormField<String>(
                value: difficulty,
                decoration: const InputDecoration(labelText: 'Dificuldade'),
                items: ['Fácil', 'Médio', 'Difícil'].map((d) {
                  return DropdownMenuItem(value: d, child: Text(d));
                }).toList(),
                onChanged: (value) => setState(() => difficulty = value!),
              ),

              const SizedBox(height: 16),

         
             TextFormField(
              initialValue: ingredients.join(', '),
              decoration: const InputDecoration(labelText: 'Ingredientes'),
              maxLines: 3,
              onSaved: (value) => ingredients = value!.split(',').map((e) => e.trim()).toList(),
             ),

              const SizedBox(height: 16),

       
              TextFormField(
                initialValue: instructions,
                decoration: const InputDecoration(labelText: 'Modo de preparo'),
                maxLines: 4,
                onSaved: (value) => instructions = value!,
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: saveEdits,
                icon: const Icon(Icons.check),
                label: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
