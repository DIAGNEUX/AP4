import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Produits extends StatefulWidget {
  const Produits({Key? key}) : super(key: key);

  @override
  State<Produits> createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {
  late List<Map<String, dynamic>> produits = []; // Initialisation de la liste produits

  String selectedCategory = 'Homme';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.1.110:3001/api/products/category/$selectedCategory'));
    if (response.statusCode == 200) {
      setState(() {
        produits = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produits', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                  text: 'Homme',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Homme';
                      fetchProducts();
                    });
                  },
                  selected: selectedCategory == 'Homme',
                ),
                FilterButton(
                  text: 'Femme',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Femme';
                      fetchProducts();
                    });
                  },
                  selected: selectedCategory == 'Femme',
                ),
                FilterButton(
                  text: 'Enfant',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Enfant';
                      fetchProducts();
                    });
                  },
                  selected: selectedCategory == 'Enfant',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: produits.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(produits[index]['nomProduit']),
                  leading: Image.asset(
                    'assets/images/${produits[index]['images'].split(',').first}',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    // Ajoutez ici la navigation vers les détails du produit
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 233, 233, 9), Color.fromARGB(255, 211, 58, 2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Ajoutez ici la logique pour ajouter un nouveau produit
          },
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool selected;

  const FilterButton({
    required this.text,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 40,
      decoration: BoxDecoration(
        gradient: selected
            ? LinearGradient(
                colors: [Color.fromARGB(255, 233, 233, 9), Color.fromARGB(255, 211, 58, 2)], // Changer les couleurs selon vos besoins
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null, // Utiliser un dégradé uniquement lorsque le bouton est activé
        borderRadius: BorderRadius.circular(30), // Changer le rayon selon vos besoins
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            selected ? Colors.transparent : Color.fromARGB(255, 131, 131, 131),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Produits(),
  ));
}
