import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/pointsCategories_Screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const String routeName = '/Categories_Screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: 'Categories',
          child: Text('Categories'),
        ),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Categorias').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading categories'),
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
                Text('Categories Screen'),
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
                            PointsCategoriesScreen.routeName,
                            arguments: categoryName, // Passa o nome da categoria como argumento
                          );
                          print('Category: $categoryName pressed');
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