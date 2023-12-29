import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/categories_Screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/pointLocal_Screen.dart';
import 'package:flutter_project/pointsCategories_Screen.dart';
import 'package:flutter_project/pointsLocations_Screen.dart';
import 'package:flutter_project/pointCat_Screen.dart';
import 'firebase_options.dart';
import 'homePage_Screen.dart';
import 'locations_Screen.dart';

void initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() {

  // Ensure that Flutter is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  initFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'), JÁ N VAMOS USAR A HOME E VAMOS POR ROTAS !
      initialRoute: MyHomePage.routeName,//NESTE MODO CRIAMOS AS NOSSAS ROTASSSS
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(title: 'TourMate Flutter'),
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        LocationsScreen.routeName: (context) => const LocationsScreen(),
        PointsCategoriesScreen.routeName: (context) =>  PointsCategoriesScreen(),
        PointsLocationsScreen.routeName: (context) =>  PointsLocationsScreen(),
        PointCatScreen.routeName: (context) =>  const PointCatScreen(categoryName: '', pointName: '',),
        PointLocalScreen.routeName: (context) =>  const PointLocalScreen(categoryName: '', pointName: '',),
        //FavoritesScreen.routeName: (context) => const FavoritesScreen(),
        //CreditsScreen.routeName: (context) => const CreditsScreen(),
      },
    );
  }
}

