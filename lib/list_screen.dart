
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {//Para passar parametros é preferivel StatelessWidget passar para statefullwidget devido ao rendimento da app
  const ListScreen({super.key});
  static const String routeName = '/ListScreen';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  late int _counter = ModalRoute.of(context)?.settings.arguments as int ?? 0;//Desta forma recebemos os nosso argumentos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Hero(
          tag: 'listscreen',
          child: Text('List Screen')),
        backgroundColor: Colors.amber,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('List Screen'),
            Text('>> $_counter <<'),
            ElevatedButton(onPressed: (){Navigator.pop(context, _counter * 2);}, child: const Text('Return')), //Leva para o MainScreen e com o pop dá para retornar o valor em dobro
          ],
        )
      ),
    );
  }
}
