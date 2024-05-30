import 'package:flutter/material.dart';

class Compte extends StatefulWidget {
  const Compte({super.key});

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  void _deconnecter() {
    Navigator.pushReplacementNamed(context, '/connexion'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Compte'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _deconnecter,
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Mon compte',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _deconnecter,
                child: Text('Se déconnecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
