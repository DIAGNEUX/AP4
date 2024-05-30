import 'package:flutter/material.dart';
import 'package:projet_ap4/page/LoadingPage.dart'; 
import 'package:projet_ap4/page/Connexion.dart'; 
import 'package:projet_ap4/tabBar.dart'; 
import 'package:projet_ap4/page/accueil.dart';
import 'package:projet_ap4/page/commande.dart';
import 'package:projet_ap4/page/compte.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPathProvider();
  runApp(const MyApp());
}

Future<void> initPathProvider() async {
  try {
    final directory = await getTemporaryDirectory();
    print('Répertoire temporaire: $directory');
  } catch (error) {
    print('Erreur lors de la récupération du répertoire temporaire: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        '/connexion': (context) => const Connexion(),
        '/tabbar': (context) => const TabBarPage(),
        '/accueil': (context) => const HomePage(),
        '/commande': (context) => const Commande(),
        '/compte': (context) => const Compte(),
        
        

      },
    );
  }
}
