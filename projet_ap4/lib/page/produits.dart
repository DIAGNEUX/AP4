import 'package:flutter/material.dart';

class Produits extends StatefulWidget {
  const Produits({super.key});

  @override
  State<Produits> createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text('mes produits!'),
    );
  }
}