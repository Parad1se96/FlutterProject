import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/point_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  static const String routeName = '/FavouriteScreen';

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late List<Map<String, String>> viewedPoints = [];

  @override
  void initState() {
    super.initState();
    _loadViewedPoints();
  }

  Future<void> _loadViewedPoints() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      viewedPoints = (prefs.getStringList('viewedPoints') ?? []).map((item) {
        Map<String, dynamic> decodedItem = json.decode(item);
        return decodedItem.map((key, value) => MapEntry(key, value.toString()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Points'),
        backgroundColor: Colors.amber,
      ),
      body: viewedPoints.isEmpty
          ? Center(child: Text('No favourite points'))
          : ListView.builder(
        itemCount: viewedPoints.length,
        itemBuilder: (context, index) {
          final pointInfo = viewedPoints[index];
          final filter = pointInfo['filter'] ?? '';
          final categoryName = pointInfo['categoryName'] ?? '';
          final pointName = pointInfo['pointName'] ?? '';

          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PointScreen(
                    filter: filter,
                    categoryName: categoryName,
                    pointName: pointName,
                  ),
                ),
              );
            },
            child: Text('$pointName '),
          );
        },
      ),
    );
  }
}