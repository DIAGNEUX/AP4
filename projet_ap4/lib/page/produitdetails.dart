import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:projet_ap4/page/modif.dart';
class ProduitDetail extends StatefulWidget {
  final Map<String, dynamic> produit;
  String apiUrl = 'http://127.0.0.1:3001';

  ProduitDetail({required this.produit, required this.apiUrl});
  
  @override
  _ProduitDetailState createState() => _ProduitDetailState();
}

class _ProduitDetailState extends State<ProduitDetail> {
  String _selectedImage = '';
  int _quantite = 1; // Initial quantité

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.produit['images'].split(',').first;
  }

  void _supprimerProduit(Uri apiUrl) {
  var produitId = widget.produit['id'];
  var deleteUrl = Uri.parse('$apiUrl/api/products/$produitId');
  http.delete(deleteUrl).then((response) {
    if (response.statusCode == 200) {
      print('Produit supprimé avec succès !');
      SnackBar snackBar = SnackBar(
        content: Text('Produit supprimé avec succès !'),
        duration: Duration(seconds: 2), 
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pop(context); 
    } else {
      print('Échec de la suppression du produit : ${response.statusCode}');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.produit['images'].split(',');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${widget.apiUrl}/uploads/$_selectedImage',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: images.map((image) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImage = image;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(2.0),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                child: Image.network(
                                  '${widget.apiUrl}/uploads/$image',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.produit['nomProduit']}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              'Produit ID : ${widget.produit['id']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              'Prix : ${widget.produit['prix']} €',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Quantité  : ${widget.produit['Quantité']}',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 30, 30, 30),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ajouter Quantité :  ',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_quantite > 1) {
                              _quantite--;
                            }
                          });
                        },
                        icon: Icon(Icons.remove),
                        color: Colors.white,
                      ),
                      Text(
                        ' $_quantite',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantite++;
                          });
                        },
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 30, 30, 30),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Supprimer',
                            style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              _supprimerProduit(Uri.parse(widget.apiUrl)); 
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: IconButton(
                        onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>ModifPage(
                                widget.apiUrl,
                                produit: widget.produit),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
