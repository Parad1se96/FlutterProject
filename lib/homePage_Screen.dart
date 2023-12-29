import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/categories_Screen.dart';
import 'package:flutter_project/lastPoints_Screen.dart';

import 'locations_Screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String routeName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.indigo,
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Keep moving forward!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20.0),

          Image.asset(
            'assets/logo.png',
            width: 200.0,
            height: 200.0,
          ),

          const SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Hero(
                 tag: 'Categories',
                 child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CategoriesScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  ),
                  child: const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Hero(
                tag: 'Locations',
              child: ElevatedButton(
                onPressed: () async  {
                  Navigator.pushNamed(context, LocationsScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                ),
                child: const Text(
                  'Locations',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, FavouriteScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                ),
                child: const Text(
                  'Recent Points',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}