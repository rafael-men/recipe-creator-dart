import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/recipe.dart';
import '../constants/oriental_countries.dart';
import '../widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDifficulty;

  final List<String> difficultyLevels = ['Fácil', 'Médio', 'Difícil'];

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
                  'assets/mare.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Encontre as receitas pela Dificuldade ;)',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: difficultyLevels.map((level) {
                    final isSelected = selectedDifficulty == level;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDifficulty = isSelected ? null : level;
                        });
                      },
                      child: Card(
                        color: isSelected ? Colors.red.shade700 : Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? Colors.red.shade700 : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Text(
                            level,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<Recipe>('recipes').listenable(),
                  builder: (context, Box<Recipe> box, _) {
                    final filteredRecipes = box.values.where((r) {
                      final isOriental = orientalCountries.contains(r.originCountry);
                      final matchesDifficulty = selectedDifficulty == null ||
                          r.difficulty == selectedDifficulty;
                      return !isOriental && matchesDifficulty;
                    }).toList();

                    if (filteredRecipes.isEmpty) {
                      return const Center(child: Text('Nenhuma receita encontrada'));
                    }

                    return ListView.builder(
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: filteredRecipes[index],
                            );
                          },
                          child: RecipeCard(recipe: filteredRecipes[index]),
                        );
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