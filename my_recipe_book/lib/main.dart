import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/recipe.dart';
// import 'models/user.dart';
import 'services/hive_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();


  await Hive.openBox<Recipe>('recipes');

  runApp(const AppLoader());
}


class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Hive.openBox<Recipe>('recipes'),
        // Hive.openBox<AppUser>('users'),
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
