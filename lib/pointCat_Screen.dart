import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PointCatScreen extends StatelessWidget {
  static const String routeName = '/PointCatScreen';

  final String categoryName;
  final String pointName;

  const PointCatScreen({Key? key, required this.categoryName, required this.pointName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Point Details'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Categorias')
            .doc(categoryName)
            .collection('points')
            .doc(pointName)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading point details'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Point not found'));
          }

          // Recupera os dados do ponto
          var pointData = snapshot.data!.data() as Map<String, dynamic>;
          String latitude = pointData['Latitude'] ?? '';
          String longitude = pointData['Longitude'] ?? '';
          String descricaoLocal = pointData['descricaoLocal'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category: $categoryName',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Point: $pointName',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Latitude: $latitude',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Longitude: $longitude',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Location Description:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  descricaoLocal,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}