import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_recipe_book/pages/create_recipe_page.dart';
import 'package:my_recipe_book/pages/homepage.dart';
import 'package:my_recipe_book/pages/login_page.dart';
import 'package:my_recipe_book/pages/signup_page.dart';
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
    // initialRoute: '/login',

    routes: {
      '/home': (context) => const HomePage(),
      '/add': (context) => const AddRecipePage(),
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignUpPage(),
    },

    home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_titles[_selectedIndex]),
            ),
            drawer: SidebarMenu(onSelectPage: _onSelectPage),
            body: _pages[_selectedIndex],
          );
        }

        return const LoginPage();
      },
    ),
  );
}

}
