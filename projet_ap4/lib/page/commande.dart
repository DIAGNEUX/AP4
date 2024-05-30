import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Commande extends StatefulWidget {
  const Commande({Key? key});
  @override
  State<Commande> createState() => _CommandeState();
}

class Order {
  final int commandeId;
  final int utilisateurId;
  final String produitIds;
  final String nomsProduits;
  final String prixProduits;
  final String imagesProduits;
  final String quantitesProduits;
  final String nom_utilisateur;
  final int note;
  final String status;
  final String commentaire;

  Order({
    required this.commandeId,
    required this.utilisateurId,
    required this.produitIds,
    required this.nomsProduits,
    required this.prixProduits,
    required this.imagesProduits,
    required this.quantitesProduits,
    required this.nom_utilisateur,
    required this.note,
    required this.status,
    required this.commentaire,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      commandeId: json['commande_id'],
      utilisateurId: json['utilisateur_id'],
      produitIds: json['produit_ids'],
      nomsProduits: json['noms_produits'],
      prixProduits: json['prix_produits'],
      imagesProduits: json['images_produits'],
      quantitesProduits: json['quantites_produits'],
      nom_utilisateur: json['nom_utilisateur'],
      status: json['status'],
      note: json['note'],
      commentaire: json['commentaire'],
    );
  }
}

class _CommandeState extends State<Commande> {
  late List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3001/api/admin-all-orders'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        orders = jsonResponse.map((data) => Order.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Commande', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(8.0),
              
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  List<Order> filteredOrders = [];
                  IconData icon;
                  String title;

                  if (index == 0) {
                    filteredOrders = orders.where((order) => order.status == 'En attente').toList();
                    icon = Icons.delivery_dining;
                    title = 'Commandes en cours';
                  } else {
                    filteredOrders = orders.where((order) => order.status == 'Expédiée').toList();
                    icon = Icons.done;
                    title = 'Commandes validées';
                  }

                  return GestureDetector(
                    onTap: () {
        
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 41, 41, 41),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              icon,
                              color: Color.fromARGB(246, 246, 193, 2),
                              size: 40,
                            ),
                            Container(
                              padding: EdgeInsets.all(0.5),
                              child: Text(
                                '${filteredOrders.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                List<int> quantites = order.quantitesProduits.split(',').map((e) => int.parse(e)).toList();
                List<int> prix = order.prixProduits.split(',').map((e) => int.parse(e)).toList();
                int totalQuantite = quantites.reduce((value, element) => value + element);
                int totalPrix = 0;
                for (int i = 0; i < prix.length; i++) {
                  totalPrix += prix[i] * quantites[i];
                }
                Color statusColor;
                switch (order.status) {
                  case 'En attente':
                    statusColor = Colors.red;
                    break;
                  case 'Expédiée':
                    statusColor = Colors.green;
                    break;
                  default:
                    statusColor = Colors.grey;
                }
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Commande de ${order.nom_utilisateur}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${order.status}',
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'quantité: ${totalQuantite}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text('prix: ${totalPrix}.€',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ))
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Commande(),
  ));
}
