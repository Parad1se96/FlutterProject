
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/pointsCategories_Screen.dart';
import 'package:flutter_project/pointsLocations_Screen.dart';
class LocationsScreen extends StatefulWidget {//Para passar parametros é preferivel StatelessWidget passar para statefullwidget devido ao rendimento da app
  const LocationsScreen({super.key});
  static const String routeName = '/Locations_Screen';

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: 'Locations',
          child: Text('Locations'),
        ),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Locais').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading locations'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final categories = snapshot.data!.docs;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Locations Screen'),
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final categoryName = category.id;

                      return ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            PointsLocationsScreen.routeName,
                            arguments: categoryName, // Passa o nome da categoria como argumento
                          );
                          print('Location: $categoryName pressed');
                        },
                        child: Text(categoryName),
                        // Adicione outras informações da categoria conforme necessário
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Return'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
