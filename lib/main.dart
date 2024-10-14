import 'package:flutter/material.dart';
import 'package:mobile_kurs2/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter RPS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String hello = '';
  int flag = 0;
  var icon = Icon(Icons.radio_button_off);

  void _startGame() {
    Navigator.push(
        context, MaterialPageRoute(
        builder: (context) =>
            Game(title: 'Flutter RPS', maxPoints: 1,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 90),
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        Color(0xffdbbaf5), //this is the background color
                    side: BorderSide(
                        color: Colors.white30,
                        width:
                            3), //you can also change the border color with this line
                  ),
                  onPressed: _startGame,
                  // child: icon,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: FittedBox(
                      fit: BoxFit.scaleDown, // масштабирование текста
                      child: Text(
                        'Начать игру',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
