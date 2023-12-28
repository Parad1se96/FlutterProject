
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {//Para passar parametros é preferivel StatelessWidget passar para statefullwidget devido ao rendimento da app
  const SecondScreen({super.key});
  static const String routeName = '/SecondScreen';

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  late int _counter = ModalRoute.of(context)?.settings.arguments as int ?? 0;//Desta forma recebemos os nosso argumentos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Hero(
          tag: 'secondscreen',
          child: Text('Second Screen')),
        backgroundColor: Colors.amber,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seconde Screen'),
            Text('>> $_counter <<'),
            ElevatedButton(onPressed: (){Navigator.pop(context, _counter * 2);}, child: const Text('Return')), //Leva para o MainScreen e com o pop dá para retornar o valor em dobro
          ],
        )
      ),
    );
  }
}
