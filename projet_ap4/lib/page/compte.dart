import 'package:flutter/material.dart';

class Compte extends StatefulWidget {
  const Compte({super.key});

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text('mon compte'),
    );
  }
}