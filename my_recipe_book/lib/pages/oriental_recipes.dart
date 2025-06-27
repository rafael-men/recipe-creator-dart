import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/recipe.dart';
import '../constants/oriental_countries.dart';
import '../widgets/recipe_card.dart';

class OrientalRecipesPage extends StatefulWidget {
  const OrientalRecipesPage({super.key});

  @override
  State<OrientalRecipesPage> createState() => _OrientalRecipesPageState();
}

class _OrientalRecipesPageState extends State<OrientalRecipesPage> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
          
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  'assets/orient.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Filtre por país:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

         
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: orientalCountries.length + 1,
                  itemBuilder: (context, index) {
                    final isAll = index == 0;
                    final country = isAll ? null : orientalCountries[index - 1];
                    final isSelected = selectedCountry == country;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCountry = country;
                          });
                        },
                        child: Card(
                          color: isSelected ? Colors.red[900] : Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: Text(
                              isAll ? 'Todos' : country!,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Lista de receitas orientais
              Expanded(
                child: ValueListenableBuilder<Box<Recipe>>(
                  valueListenable: Hive.box<Recipe>('recipes').listenable(),
                  builder: (context, box, _) {
                    final orientalRecipes = box.values.where((r) => r.recipeType == 'oriental');

                    final filteredRecipes = selectedCountry == null
                        ? orientalRecipes.toList()
                        : orientalRecipes.where((r) => r.originCountry == selectedCountry).toList();

                    if (filteredRecipes.isEmpty) {
                      return const Center(child: Text('Nenhuma receita oriental encontrada'));
                    }

                    return ListView.builder(
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(recipe: filteredRecipes[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF8B0000),
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/add');
              },
            ),
          ),
        ],
      ),
    );
  }
}
