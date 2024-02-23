import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/custom.dart';


class StartPage extends StatelessWidget {
  final VoidCallback goToPlayGame;
  final VoidCallback showInstruction;

  const StartPage(
      {super.key, required this.goToPlayGame, required this.showInstruction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              text: 'MEGA',
              style: GoogleFonts.russoOne()
                  .copyWith(color: Colors.red, fontSize: 40),
              children: [
                TextSpan(
                  text: 'ROLL',
                  style: GoogleFonts.russoOne()
                      .copyWith(color: Colors.black, fontSize: 40),
                )
              ]),
        ),
        Image.asset('images/welcome.png'),
        DiceButton(
            label: "START GAME",
            onPressed: goToPlayGame,
            buttonColor: Colors.green,
            textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
        DiceButton(
            label: "HOW TO PLAY",
            onPressed: showInstruction,
            buttonColor: Colors.black54,
            textStyle: const TextStyle(color: Colors.white, fontSize: 20))
      ],
    );
  }
}
