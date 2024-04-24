import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'favourites.dart';
import 'home.dart';
import 'createrefill.dart';
import 'settings.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      title: 'Your App',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      routes: {
        '/favourites': (context) => const FavoritesScreen(),
        '/createRefill': (context) => const CreateRefillScreen(),
        '/settings': (context) => const SettingsScreen(),
        
        
        // Add more routes as needed
      },
      initialRoute: '/',
    );
  }
}
