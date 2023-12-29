import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/point_Screen.dart';

class PointsLocationsScreen extends StatefulWidget {
  static const String routeName = '/PointsLocations_Screen';

  @override
  State<PointsLocationsScreen> createState() => _PointsLocationsScreenState();
}

class _PointsLocationsScreenState extends State<PointsLocationsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final String locationName = ModalRoute.of(context)!.settings.arguments as String;
    final CollectionReference pointsCollection = _firestore.collection('Locais').doc(locationName).collection('points');

    return Scaffold(
      appBar: AppBar(
        title: Text('Points for $locationName'),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: pointsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading points'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final points = snapshot.data!.docs;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Points for $locationName'),
                if (points.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: points.length,
                      itemBuilder: (context, index) {
                        final pointDocument = points[index];
                        final pointName = pointDocument.id;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PointScreen(
                                    filter: "Locais",
                                    categoryName: locationName,
                                    pointName: pointName,
                                  ),
                                ),
                              );
                            },
                            child: Text(pointName),
                          ),
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