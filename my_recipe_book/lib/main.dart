import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_recipe_book/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'models/recipe.dart';
// import 'models/user.dart';
import 'services/hive_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: const FirebaseOptions(
      apiKey: "AIzaSyAznKl7t631Kh1mwimLp3LqvpQJSx2r2YI",
      authDomain: "recipe-app-16f66.firebaseapp.com",
      projectId: "recipe-app-16f66",
      storageBucket: "recipe-app-16f66.firebasestorage.app",
      messagingSenderId: "460889163066",
      appId: "1:460889163066:web:2b83b08efbf82993083c03",
      measurementId: "G-TTXHCGGRPQ",
    ),
  );
  await HiveService.init();
  await Hive.openBox<Recipe>('recipes');

   runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: const AppLoader(),
    ),
  );
}


class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Hive.openBox<Recipe>('recipes'),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const RecipeApp(); 
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
