import 'package:flutter/material.dart';
import '../chart/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(237, 0, 0, 0),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text('Dashbords',style: TextStyle(color: Colors.white, fontSize: 30),),
            ),
            Expanded( 
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  
                ),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: [
                    Container(
                      color: Colors.red,
                      child: Text('Cellule 1'),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Text('Cellule 2'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Text('Statistiques',style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 55, 55, 55).withOpacity(0.5),
              ),              
              child: Center(
                child: LineChartSample2(), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
