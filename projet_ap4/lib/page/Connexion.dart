import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3001/api/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'emailUser': email,
          'passwordUser': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Connecté avec succès');
        print(data);
        Navigator.pushReplacementNamed
        (context,'/tabbar');
        
      } else {
        print('Échec de la connexion');
      }
    } catch (error) {
      print('Erreur: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/lastone.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  suffixIcon: Icon(Icons.visibility),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(246, 246, 193, 2),
                  onPrimary: Colors.black,
                ),
                onPressed: login,
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
