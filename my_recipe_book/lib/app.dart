import 'package:flutter/material.dart';
import 'package:my_recipe_book/pages/create_recipe_page.dart';
import 'package:my_recipe_book/pages/homepage.dart';
import 'pages/homepage.dart';
import 'pages/oriental_recipes.dart';
import 'theme.dart';
import 'widgets/sidebar_menu.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    OrientalRecipesPage(),
  ];

  final List<String> _titles = [
    'Receitas Tradicionais',
    'Receitas Orientais',
  ];

  void _onSelectPage(int index) {
  setState(() {
    _selectedIndex = index;
  });
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas Culinárias',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
       routes: {
         '/add': (context) => const AddRecipePage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedIndex]),
        ),
        drawer: SidebarMenu(onSelectPage: _onSelectPage),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
