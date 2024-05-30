import 'dart:math';

import 'package:flutter/material.dart';
import '../chart/chart.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int articlesVendusAujourdhui = Random().nextInt(10000);
  int articlesEnStock = Random().nextInt(500);
  int commandesEnCours = Random().nextInt(50);
  int rupturesDeStock = Random().nextInt(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenue, Alioune',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(237, 0, 0, 0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Dashboards',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(),
                child: GridView.count(
                  padding: EdgeInsets.all(8),
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.4,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 41, 41, 41),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Color.fromARGB(246, 246, 193, 2),
                            size: 30,
                          ),
                          Container(
                              padding: EdgeInsets.all(0.5),
                              child: Text('$articlesVendusAujourdhui',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Text(
                            'articles vendus',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 41, 41, 41),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.inventory,
                            color: Color.fromARGB(246, 246, 193, 2),
                            size: 30,
                          ),
                          Container(
                              padding: EdgeInsets.all(0.5),
                              child: Text('$articlesEnStock',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Text(
                            'articles en stock',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 41, 41, 41),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Color.fromARGB(246, 246, 193, 2),
                            size: 30,
                          ),
                          Container(
                              padding: EdgeInsets.all(0.5),
                              child: Text('$commandesEnCours',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                          Text(
                            'commande en cours',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 41, 41, 41),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Color.fromARGB(246, 246, 193, 2),
                            size: 30,
                          ),
                          Container(
                              padding: EdgeInsets.all(0.5),
                              child: Text('$rupturesDeStock',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                          Text(
                            'rupture de stock',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Statistics',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    child: LineChartSample2(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}




