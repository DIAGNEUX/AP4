import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_ap4/page/produitdetails.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';



class Produits extends StatefulWidget {
  const Produits({Key? key}) : super(key: key);

  @override
  State<Produits> createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {
  late List<Map<String, dynamic>> produits = [];
  String selectedCategory = 'Homme';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  static const String apiUrl = 'http://127.0.0.1:3001';

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('$apiUrl/api/products/category/$selectedCategory'));
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
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(16.0), child: Text('Produits', 
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.white
            ))),
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                mainAxisExtent: 180, 
              ),
              itemCount: produits.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: const Color.fromARGB(255, 30, 30, 30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProduitDetail(produit: produits[index], apiUrl: apiUrl),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        Expanded(
                          flex: 7,
                          child: Image.network(
                            '$apiUrl/uploads/${produits[index]['images'].split(',').first}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Expanded(
                          flex: 3, 
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produits[index]['nomProduit'],
                                  style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold , fontSize: 10
                                    ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.white, fontSize: 10),
                                    children: [
                                      TextSpan(
                                        text: '${produits[index]['Quantite']} ',
                                        style: TextStyle(
                                          color: produits[index]['Quantite'] < 5
                                              ? Colors.red 
                                              : produits[index]['Quantite'] < 10
                                                  ? Colors.orange 
                                                  : Colors.white, 
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'dans le stock',
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(246, 246, 193, 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AjouterProduitPopup(); 
              },
            );
          },
          child: const Icon(Icons.add, color: Colors.black),
          backgroundColor:const Color.fromARGB(246, 246, 193, 2),
        ),
      ),
    );
  }
}



class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
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
        color: selected
            ? const Color.fromARGB(246, 246, 193, 2)
            : null,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            selected
                ? const Color.fromARGB(246, 246, 193, 2)
                : const Color.fromARGB(255, 54, 53, 53),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: selected ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}




class AjouterProduitPopup extends StatefulWidget {
  @override
  _AjouterProduitPopupState createState() => _AjouterProduitPopupState();
}

class _AjouterProduitPopupState extends State<AjouterProduitPopup> {
  final TextEditingController nomProduitController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController couleurController = TextEditingController();
  final TextEditingController tailleController = TextEditingController();
  final TextEditingController promoController = TextEditingController();
  final TextEditingController cateTypeController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController quantiteController = TextEditingController();

  List<XFile> selectedImages = [];

final String defaultImagePath = 'assets/images/logo.png';


Future<void> _addProductWithImages(Map<String, dynamic> productData, List<XFile> images) async {
  final url = Uri.parse('http://127.0.0.1:3001/api/product');
  final request = http.MultipartRequest('POST', url);

  productData.forEach((key, value) {
    request.fields[key] = value.toString();
  });

  if (images.isNotEmpty) {
    for (int i = 0; i < images.length; i++) {
      var stream = http.ByteStream(images[i].openRead());
      var length = await images[i].length();
      var multipartFile = http.MultipartFile('images', stream, length, filename: 'image_$i.jpg');
      request.files.add(multipartFile);
    }
  }

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Produit ajouté avec succès !');
    } else {
      print('Échec de l\'ajout du produit : ${response.reasonPhrase}');
    }
  } catch (error) {
    print('Erreur lors de l\'envoi de la requête : $error');
  }
}


  Future<void> _selectImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage(
      imageQuality: 100, 

    );

  if (images != null && images.isNotEmpty) {
  } else {
    print('Aucune image sélectionnée, ajout de l\'image par défaut');
    selectedImages = [XFile(defaultImagePath)];
  }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un produit'),
      contentPadding: const EdgeInsets.all(8.0),
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nomProduitController,
                decoration: const InputDecoration(labelText: 'Nom du produit'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: categorieController,
                decoration: const InputDecoration(labelText: 'Catégorie'),
              ),
              TextField(
                controller: couleurController,
                decoration: const InputDecoration(labelText: 'Couleur'),
              ),
              TextField(
                controller: tailleController,
                decoration: const InputDecoration(labelText: 'Taille'),
              ),
              TextField(
                controller: promoController,
                decoration: const InputDecoration(labelText: 'Promotion'),
              ),
              TextField(
                controller: cateTypeController,
                decoration: const InputDecoration(labelText: 'Type de catégorie'),
              ),
              TextField(
                controller: prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
              ),
              ElevatedButton(
                onPressed: _selectImages,
                child: const Text('Sélectionner des images'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () async {
            final Map<String, dynamic> productData = {
              'nomProduit': nomProduitController.text,
              'description': descriptionController.text,
              'categorie': categorieController.text,
              'couleur': couleurController.text,
              'taille': tailleController.text,
              'promo': promoController.text,
              'cateType': cateTypeController.text,
              'prix': prixController.text,
            };
            await _addProductWithImages(productData, selectedImages);
            Navigator.of(context).pop();
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Produits(),
  ));
}