import 'dart:math';

import 'package:flutter/material.dart';
import 'package:state_management/pages/start_page.dart';

import '../utils/constants.dart';
import '../utils/custom.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameStatus gameStatus = GameStatus.none;

  final random = Random.secure();
  int index1 = 0, index2 = 0, diceSum = 0, target = 0;
  String result = '';
  bool hasTarget = false, shouldShowBoard = false;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    return Scaffold(
      body: Center(
        child: shouldShowBoard
            ? Stack(
                children: [
                  // Background Image
                  Image.asset('images/background.png'),
                  // Centered Column
                  Positioned(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Dice Images Row
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Constants.diceImages[index1],
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Constants.diceImages[index2],
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Dice Sum : $diceSum',
                          style: const TextStyle(fontSize: 24),
                        ),
                        if (hasTarget && gameStatus == GameStatus.running)
                          Text(
                            'Your target : $target\nkeep rolling to match $target',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        Text(
                          result,
                          style: const TextStyle(
                              fontSize: 32, color: Colors.green),
                        ),
                        if (gameStatus == GameStatus.running)
                          DiceButton(
                              label: "ROLL",
                              onPressed: rollTheDice,
                              buttonColor: Colors.green,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        if (gameStatus == GameStatus.over)
                          DiceButton(
                              label: "RESET",
                              onPressed: reset,
                              buttonColor: Colors.redAccent[400]!,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20))
                      ],
                    ),
                  ),
                ],
              )
            : StartPage(
                goToPlayGame: goToGamePage,
                showInstruction: () {
                  showInstruction(context);
                },
              ),
      ),
    );
  }

  void rollTheDice() {
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      diceSum = (index1 + index2) + 2;
      if (hasTarget) {
        checkTarget();
      } else {
        checkFirstRoll();
      }
    });
  }

  void checkTarget() {
    if (diceSum == target) {
      result = Constants.win;
      gameStatus = GameStatus.over;
    } else if (diceSum == 7) {
      result = Constants.loss;
      gameStatus = GameStatus.over;
    }
  }

  void checkFirstRoll() {
    if (diceSum == 7 || diceSum == 11) {
      result = Constants.win;
      gameStatus = GameStatus.over;
    } else if (diceSum == 2 || diceSum == 3 || diceSum == 12) {
      result = Constants.loss;
      gameStatus = GameStatus.over;
    } else {
      //KEEP ROLLING FOR TARGET SUM
      hasTarget = true;
      target = diceSum;
    }
  }

  void reset() {
    setState(() {
      index1 = 0;
      index2 = 0;
      diceSum = 0;
      result = '';
      target = 0;
      hasTarget = false;
      shouldShowBoard = false;
      gameStatus = GameStatus.none;
    });
  }

  void goToGamePage() {
    setState(() {
      shouldShowBoard = true;
      gameStatus = GameStatus.running;
    });
  }

  showInstruction(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("INSTRUCTION"),
              content: const Text(gameRules),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("CLOSE"))
              ],
            ));
  }
}

const gameRules = '''
* AT THE FIRST ROLL, IF THE DICE SUM IS 7 OR 11, YOU WIN! \n
* AT THE FIRST ROLL, IF THE DICE SUM IS 2, 3 OR 12, YOU LOST!! \n
* AT THE FIRST ROLL, IF THE DICE SUM IS 4, 5, 6, 8, 9, 10, THEN THIS DICE SUM WILL BE YOUR TARGET POINT, AND KEEP ROLLING  \n
* IF THE DICE SUM MATCHES YOUR TARGET POINT, YOU WIN! \n
* IF THE DICE SUM IS 7, YOU LOST!! \n
''';
