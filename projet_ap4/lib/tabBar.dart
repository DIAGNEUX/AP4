import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'page/accueil.dart';
import 'page/produits.dart';
import 'page/commande.dart';
import 'page/compte.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Produits(),
    const Commande(),
    const Compte(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 41, 41, 41),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: const Duration(milliseconds: 800),
            tabBackgroundColor: Colors.grey[800]!,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Accueil',
                iconColor: Colors.grey[400],
                textStyle: TextStyle(color: Colors.white),
              ),
              GButton(
                icon: Icons.store,
                text: 'Produits',
                iconColor: Colors.grey[400],
                textStyle: TextStyle(color: Colors.white),
              ),
              GButton(
                icon: Icons.dashboard,
                text: 'Commande',
                iconColor: Colors.grey[400],
                textStyle: TextStyle(color: Colors.white),
              ),
              GButton(
                icon: Icons.person,
                text: 'Compte',
                iconColor: Colors.grey[400],
                textStyle: TextStyle(color: Colors.white),
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
