import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointScreen extends StatefulWidget {
  static const String routeName = '/PointLocalScreen';
  final String filter;
  final String categoryName;
  final String pointName;

  const PointScreen({Key? key, required this.filter, required this.categoryName, required this.pointName}) : super(key: key);

  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  late String pointName;
  late String categoryName;
  late String filter;

  @override
  void initState() {
    super.initState();
    pointName = widget.pointName;
    categoryName = widget.categoryName;
    filter = widget.filter;
    _incrementPointer();
  }

  Future<void> _incrementPointer() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> viewedPointsStrings = prefs.getStringList('viewedPoints') ?? [];

    // Adicione informações do ponto ao mapa
    Map<String, String> pointInfo = {
      'filter': filter,
      'categoryName': categoryName,
      'pointName': pointName,
    };

    // Adicione o mapa à lista após codificar como JSON
    viewedPointsStrings.add(json.encode(pointInfo));

    // Se houver mais de 10 elementos, remova o mais antigo
    if (viewedPointsStrings.length > 10) {
      viewedPointsStrings.removeAt(0);
    }

    // Salve a lista atualizada
    await prefs.setStringList('viewedPoints', viewedPointsStrings);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Point Details'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection(filter)
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

          var pointData = snapshot.data!.data() as Map<String, dynamic>;
          String latitude = pointData['Latitude'] ?? '';
          String longitude = pointData['Longitude'] ?? '';
          String descricaoLocal = pointData['descricaoLocal'] ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(filter == 'Locais')
                Text(
                  'Location: $categoryName',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              if(filter == 'Categorias')
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
              SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }
}