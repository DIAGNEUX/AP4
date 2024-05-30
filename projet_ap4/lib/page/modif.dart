import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'produits.dart'; // Importez la page Produits si nécessaire

class ModifPage extends StatefulWidget {
  String apiUrl;
  final Map<String, dynamic> produit;

  ModifPage(this.apiUrl, {required this.produit});

  @override
  _ModifPageState createState() => _ModifPageState();
}

class _ModifPageState extends State<ModifPage> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categorieController = TextEditingController();
  TextEditingController _couleurController = TextEditingController();
  TextEditingController _tailleController = TextEditingController();
  TextEditingController _prixController = TextEditingController();
  TextEditingController _promoController = TextEditingController();
  TextEditingController _cateTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomController.text = widget.produit['nomProduit'];
    _descriptionController.text = widget.produit['description'];
    _categorieController.text = widget.produit['categorie'];
    _couleurController.text = widget.produit['couleur'];
    _tailleController.text = widget.produit['taille'];
    _prixController.text = widget.produit['prix'].toString();
    _promoController.text = widget.produit['promo'].toString();
    _cateTypeController.text = widget.produit['cateType'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le produit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom du produit'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _categorieController,
                decoration: InputDecoration(labelText: 'Catégorie'),
              ),
              TextFormField(
                controller: _couleurController,
                decoration: InputDecoration(labelText: 'Couleur'),
              ),
              TextFormField(
                controller: _tailleController,
                decoration: InputDecoration(labelText: 'Taille'),
              ),
              TextFormField(
                controller: _prixController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Prix'),
              ),
              TextFormField(
                controller: _promoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Promo'),
              ),
              TextFormField(
                controller: _cateTypeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Catégorie Type'),
              ),
              ElevatedButton(
                onPressed: () {
                  _modifierProduit();
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _modifierProduit() {
    String nomProduit = _nomController.text;
    String description = _descriptionController.text;
    String categorie = _categorieController.text;
    String couleur = _couleurController.text;
    String taille = _tailleController.text;
    double prix = double.parse(_prixController.text);
    double promo = double.parse(_promoController.text);
    String cateType = _cateTypeController.text;

    // Créer un objet représentant les données à envoyer
    Map<String, dynamic> data = {
      "nomProduit": nomProduit,
      "description": description,
      "categorie": categorie,
      "couleur": couleur,
      "taille": taille,
      "prix": prix,
      "promo": promo,
      "cateType": cateType,
    };

    http.put(
      Uri.parse('${widget.apiUrl}/api/product/${widget.produit['id']}'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    ).then((response) {
      if (response.statusCode == 200) {
        print(widget.apiUrl);
        print('Produit mis à jour avec succès !');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Modification réussie !'),
            duration: Duration(seconds: 2), 
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Produits(), 
            ),
          );
        });
      } else {
        print(widget.apiUrl);
        print('Échec de la mise à jour du produit : ${response.statusCode}');
      }
    }).catchError((error) {
      print('Erreur lors de la mise à jour du produit : $error');
    });
  }
}
