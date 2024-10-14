import 'package:flutter/material.dart';
import 'package:mobile_kurs2/main.dart';
import 'package:mobile_kurs2/game.dart';
import 'dart:math';

class Settings extends StatefulWidget {
  final String title;
  final int curMaxPoints;
  const Settings({super.key, required this.title, required this.curMaxPoints});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int curMaxPoints = 0; // или другое начальное значение
  int points = 0;

  @override
  void initState() {
    super.initState();
    curMaxPoints = widget.curMaxPoints;
  }

  void _savePoints(points) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Game(
                  title: 'Flutter RPS',
                  maxPoints: points,
                )));
  }

  @override
  Widget build(BuildContext context) {
    // final dynamic categoryId = ModalRoute.of(context)!.settings.arguments;
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            // home: const MyHomePage(title: 'Wallet App'),
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .inversePrimary, // Цвет фона заголовка
              title: const Text(
                'Назад',
                style: TextStyle(
                    color: Color(0xFF160E73)), // Цвет текста заголовка
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MyHomePage(title: 'Flutter RPS')),
                  //       (Route<dynamic> route) =>
                  //   false, // Удаление всех предыдущих маршрутов
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Game(
                                title: 'Flutter RPS',
                                maxPoints: curMaxPoints,
                              )));
                },
              ),
            ),
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 50, 10, 5),
                child: Text(
                  "Очков для победы",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(140, 0, 140, 5),
                child: TextField(
                    textAlign: TextAlign.center,
                    // decoration: InputDecoration(labelText: "Очков для победы"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      points = int.parse(value);
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                  width: 160,
                  height: 50,
                  child: TextButton(
                  onPressed: () => _savePoints(points),
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        Color(0xffdbbaf5), //this is the background color
                    side: BorderSide(
                        color: Colors.white30,
                        width:
                            3), //you can also change the border color with this line
                  ),
                  child: Text("Сохранить", style: TextStyle(fontSize: 20),)))
            ])));
  }
}
