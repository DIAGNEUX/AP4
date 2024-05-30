import 'package:flutter/material.dart';
import 'package:projet_ap4/page/Connexion.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Connexion()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 246, 193, 2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [     
            Image.asset('images/logo.png',), 
            const SizedBox(height: 20), 
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
