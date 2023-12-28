import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/list_screen.dart';

void main() {
  print('Ola bom dia até logoo');
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
      //home: const MyHomePage(title: 'Flutter Demo Home Page'), JÁ N VAMOS USAR A HOME E VAMOS POR ROTAS NESTA MERDA!
      initialRoute: MyHomePage.routeName,//NESTE MODO CRIAMOS AS NOSSAS ROTASSSS
      routes: {
        MyHomePage.routeName : (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        ListScreen.routeName: (context) => ListScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  static const String routeName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _color = Colors.white;

  void _incrementCounter() {
    _changeColor();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _decrementCounter() { //Não interessa se está dentro ou fora do setState. Desde que ele seja chamado para criar a atualização da app!
    _changeColor();
    _counter --;
    setState(() {
    });
  }

  void _changeColor() { //Não interessa se está dentro ou fora do setState. Desde que ele seja chamado para criar a atualização da app!
    final r = Random().nextInt(256);
    final g = Random().nextInt(256);
    final b = Random().nextInt(256);
    _color = Color.fromARGB(255, r, g, b);
  }

  void _showLogo(){


  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: _color,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //if(_counter > 10)
              //FlutterLogo(size: MediaQuery.of(context).size.width / 2,),

            FlutterLogo(size: _counter > 10 ? MediaQuery.of(context).size.width / 2 : 0,),//Outra forma de fazer o que está comentado criando uma animação de 0 a seu tamanho original
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: () {
              _resetCounter();
            }, child: const Text('Reset')),
            Hero(
              tag: 'listscreen',
              child: ElevatedButton(
                  onPressed: () async {
                   var obj = await Navigator.pushNamed(context, ListScreen.routeName, arguments: _counter);

                  // res.then((value) => { setState(() {})});
                    int i = obj is int ? obj : 1234;//O significado do 1234 é caso falha a devolver o valor, é este o valor default
                    setState(() {_counter = i;});
                  },
                  child: const Text('List Screen')),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32,0,0,0),//Corrigir o 16dp default do botao da direita
            child: FloatingActionButton(
              heroTag: 'fb1',
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
          FloatingActionButton(
            heroTag: 'fb2',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
