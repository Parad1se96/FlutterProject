import 'dart:convert';
import 'dart:typed_data';

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
  late String liked;

  @override
  void initState() {
    super.initState();
    pointName = widget.pointName;
    categoryName = widget.categoryName;
    filter = widget.filter;
    _incrementPointer(null);
  }

  Future<void> _incrementPointer(bool ?like) async {
    var prefs = await SharedPreferences.getInstance();
    List<String> viewedPointsStrings = prefs.getStringList('viewedPoints') ?? [];
    var flag = false;

    // Adicione informações do ponto ao mapa
    Map<String, String> pointInfo = {
      'filter': filter,
      'categoryName': categoryName,
      'pointName': pointName,
      'like': like.toString(),
    };

    viewedPointsStrings.forEach((element) {

      Map<String, dynamic> pointInfo = json.decode(element);
      String pointNameList = pointInfo['pointName'];


      if(pointNameList == pointName) {
        liked = pointInfo['like'];
        flag = true;
      }
    });


      // Adicione o mapa à lista após codificar como JSON
      viewedPointsStrings.add(json.encode(pointInfo));

    // Se houver mais de 10 elementos, remova o mais antigo
    if (viewedPointsStrings.length > 10) {
      viewedPointsStrings.removeAt(0);
    }
    if(!flag) {
      // Salve a lista atualizada
      await prefs.setStringList('viewedPoints', viewedPointsStrings);
    }
  }


  Future<void> _updatePointer(bool? like) async {
    var prefs = await SharedPreferences.getInstance();
    List<String> viewedPointsStrings = prefs.getStringList('viewedPoints') ?? [];

    for (int i = 0; i < viewedPointsStrings.length; i++) {
      Map<String, dynamic> pointInfo = json.decode(viewedPointsStrings[i]);

      if (pointInfo['pointName'] == pointName) {
        pointInfo['like'] = like.toString();
        viewedPointsStrings[i] = json.encode(pointInfo); // Atualize o elemento na lista original
        print(pointInfo['like']);
      }
    }

    print(viewedPointsStrings);
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
              // Informações existentes do ponto
              Text(
                'Location: $categoryName',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
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

              // Botões Gosto e Não Gosto
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para "Gosto"
                      _updatePointer(true);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: liked == "true" ? Colors.green : null, // Cor verde quando liked é true
                    ),
                    child: Text('Gosto'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para "Não Gosto"
                      _updatePointer(false);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: liked == "false" ? Colors.red : null, // Cor vermelha quando liked é false
                    ),
                    child: Text('Não Gosto'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}