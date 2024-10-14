import 'package:flutter/material.dart';
import 'package:mobile_kurs2/main.dart';
import 'package:mobile_kurs2/settings.dart';
import 'dart:math';

class Game extends StatefulWidget {
  final String title;
  final int maxPoints;
  const Game({super.key, required this.title, required this.maxPoints});

  @override
  State<Game> createState() => _GameState();
}

enum Items { rock, paper, scissors }

class _GameState extends State<Game> {
  String resultStr = "Ваш ход!";
  String compChoiceStr = "";
  Items userChoice = Items.rock;
  Items compChoice = Items.rock;
  String item = "";
  int otherIdx = 0;
  var intValue = Random().nextInt(3);

  int userPoints = 0;
  int compPoints = 0;
  int draw = 0;
  int userCurPoints = 0;
  int compCurPoints = 0;
  int actionCnt = 0;

  Color baseBack = Color(0xfff7f5fa);
  Color pressedBack = Color(0xffe1d9f3);
  Color rockBack = Color(0xfff7f5fa);
  Color paperBack = Color(0xfff7f5fa);
  Color scissorsBack = Color(0xfff7f5fa);

  int maxPoints = 0;  // или другое начальное значение

  @override
  void initState() {
    super.initState();
    maxPoints = widget.maxPoints;
  }

  String checkItem(item) {
    if (item == Items.rock)
      return "камень";
    else if (item == Items.rock)
      return "бумагу";
    else
      return "ножницы";
  }

  void changeBack(item) {
    if (item == Items.rock) {
      rockBack = pressedBack;
      paperBack = baseBack;
      scissorsBack = baseBack;
    } else if (item == Items.paper) {
      rockBack = baseBack;
      paperBack = pressedBack;
      scissorsBack = baseBack;
    } else if (item == Items.scissors) {
      rockBack = baseBack;
      paperBack = baseBack;
      scissorsBack = pressedBack;
    }
  }

  void pressBtn(item) {
    setState(() {
      changeBack(userChoice);
      actionCnt += 1;
      checkWinner(userPoints, compPoints, maxPoints);
      otherIdx = Random().nextInt(3);
      compChoiceStr = checkItem(Items.values[otherIdx]);
      checkWin(userChoice, Items.values[otherIdx]);
      resultStr = getResStr(userCurPoints, compCurPoints);
      // "Вы выбрали ${item}\nА противник выбрал ${compChoiceStr}\n"
      //     "${userCurPoints} и ${compCurPoints} и ${draw}";
      userCurPoints = 0;
      compCurPoints = 0;

    });
  }

  String getResStr(user, comp) {
    if (user == 1)
      return "Победили Вы!";
    else if (comp == 1)
      return "Победил Компьютер!";
    else
      return "Ничья!";
  }

  void checkWinner(user, comp, points){
    if (user == points) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text("Поздравляем!"),
            content: Text("Вы победили!", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            actions: <Widget>[
              TextButton(
                child: Text("Закрыть"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Flutter RPS')),
                        (Route<dynamic> route) =>
                    false, // Удаление всех предыдущих маршрутов
                  );
                },
              ),
            ],
          );
        },
      );
    }
    if (comp == points) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text("Поздравляем!"),
            content: Text("Победил Комьютер!", style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            actions: <Widget>[
              TextButton(
                child: Text("Закрыть"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Flutter RPS')),
                        (Route<dynamic> route) =>
                    false, // Удаление всех предыдущих маршрутов
                  );
                },
              ),
            ],
          );
        },
      );
    }
      // return "Победил Комьютер!";
  }

  void checkWin(user, comp) {
    print("user: ${user}, comp: ${comp}");
    if ((user == Items.rock && comp == Items.scissors) ||
        (user == Items.scissors && comp == Items.paper) ||
        (user == Items.paper && comp == Items.rock)) {
      userPoints += 1;
      userCurPoints = 1;
    } else if ((user == Items.rock && comp == Items.paper) ||
        (user == Items.scissors && comp == Items.rock) ||
        (user == Items.paper && comp == Items.scissors)) {
      compPoints += 1;
      compCurPoints = 1;
    } else
      draw = 1;
    checkWinner(userPoints, compPoints, maxPoints);
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
              style:
                  TextStyle(color: Color(0xFF160E73)), // Цвет текста заголовка
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Flutter RPS')),
                  (Route<dynamic> route) =>
                      false, // Удаление всех предыдущих маршрутов
                );
              },
            ),
          ),
          body: Stack(children: [
            Positioned(
                top: 10, // Расстояние от верхнего края
                right: 10, // Расстояние от правого края
                child: GestureDetector(
                  onTap: () {
                    // resultStr = "Настройки";
                    // print(resultStr);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Settings(title: 'Flutter RPS', curMaxPoints: maxPoints,)),
                      // (Route<dynamic> route) =>
                      //     false, // Удаление всех предыдущих маршрутов
                    );
                  },
                  child: Icon(
                    Icons.settings,
                    size: 35,
                  ),
                )),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "Играем до ${maxPoints}",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF160E73),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  resultStr,
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF160E73),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                  visible: actionCnt > 0,
                  child: Container(
                      width: 200,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      // height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xfff7f5fa),
                      ),
                      child: Column(children: <Widget>[
                        Visibility(
                          visible: Items.values[otherIdx] == Items.rock,
                          child: Image.asset('assets/images/rock.png',
                              width: 90, height: 90),
                        ),
                        Visibility(
                          visible: Items.values[otherIdx] == Items.paper,
                          child: Image.asset('assets/images/paper.png',
                              width: 90, height: 90),
                        ),
                        Visibility(
                          visible: Items.values[otherIdx] == Items.scissors,
                          child: Image.asset('assets/images/scissors.png',
                              width: 90, height: 90),
                        ),
                      ]))),

              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  "Компьютер",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF4C9449),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: Text(
              //     "${userPoints} : ${compPoints}",
              //     style: TextStyle(fontSize: 30),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 30,
                      // margin: EdgeInsets.fromLTRB(10, 60, 10, 40),
                      child: Text(
                        "${userPoints} ",
                        style:
                            TextStyle(fontSize: 30, color: Color(0xFFA889EF)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.fromLTRB(10, 60, 10, 40),
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 30,
                      // margin: EdgeInsets.fromLTRB(10, 60, 10, 40),
                      child: Text(
                        "${compPoints}",
                        style:
                            TextStyle(fontSize: 30, color: Color(0xFF4C9449)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
                child: Text(
                  "Вы",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFA889EF),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),

              // Container(
              //   margin: EdgeInsets.fromLTRB(10, 10, 10, 50),
              //   child: Text(
              //     resultStr,
              //     style: TextStyle(fontSize: 20),
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              // Image.asset('assets/images/rock.png', width: 100, height: 100),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(width: 30),
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                // Здесь добавь действие, которое нужно выполнить при нажатии на кнопку
                                item = "камень";
                                userChoice = Items.rock;
                                pressBtn(item);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: rockBack,
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xffd3a4f8),
                                        width: 3,
                                      ),
                                      bottom: BorderSide(
                                        color: Color(0xffd3a4f8),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Column(children: <Widget>[
                                    Image.asset('assets/images/rock.png',
                                        width: 90, height: 90),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Камень',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ])))),
                      SizedBox(width: 50),
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                // Здесь добавь действие, которое нужно выполнить при нажатии на кнопку
                                item = "бумагу";
                                userChoice = Items.paper;
                                pressBtn(item);
                              },
                              child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: paperBack,
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xffd3a4f8),
                                        width: 3,
                                      ),
                                      bottom: BorderSide(
                                        color: Color(0xffd3a4f8),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Column(children: <Widget>[
                                    Image.asset('assets/images/paper.png',
                                        width: 90, height: 90),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Бумага',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ])))),
                      SizedBox(width: 30),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 50),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(width: 130),
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                // Здесь добавь действие, которое нужно выполнить при нажатии на кнопку
                                item = "ножницы";
                                userChoice = Items.scissors;
                                pressBtn(item);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: scissorsBack,
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xffd3a4f8),
                                        width: 3,
                                      ),
                                      bottom: BorderSide(
                                        color: Color(0xffd3a4f8),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Column(children: <Widget>[
                                    Image.asset('assets/images/scissors.png',
                                        width: 90, height: 90),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Ножницы',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ])))),
                      SizedBox(width: 120),
                    ],
                  ))
            ])
          ])),
    );
  }
}
