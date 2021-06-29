import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario/jumping.dart';
import 'package:super_mario/mario.dart';
import 'package:super_mario/mushroom.dart';
import 'dart:async';
import 'button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double time = 0;
  double mushX = 0.5;
  double marioSize = 70 ;
  double mushY = 1;
  bool midjump = false;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void CheckIfAtemush(){
    if((marioX - mushX).abs() < 0.05 && (marioY - mushY).abs() < 0.05){
        setState(() {
          mushX =2;
          marioSize = 100;
        });
    }
  }
  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (midjump == false) {
      midjump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if (initialHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
            timer.cancel();
          });
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      CheckIfAtemush();
      if (Button().userIsHoldingButton() == true && (marioX + 0.02)<1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";

    Timer.periodic(Duration(milliseconds: 50), (timer){
      CheckIfAtemush();
      if (Button().userIsHoldingButton() == true && (marioX - 0.02)> -1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    child: AnimatedContainer(
                      alignment: Alignment(marioX, marioY),
                      duration: Duration(milliseconds: 0),
                      child: midjump
                          ? jumpingmario(
                              direction: direction,
                        size: marioSize,
                            )
                          : Mymario(
                              direction: direction,
                              midrun: midrun,
                        size: marioSize,
                            ),
                    ),
                    color: Colors.lightBlue[600],
                  ),
                  Container(alignment: Alignment(mushX, mushY), child: Mymushroom()),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Super Mario",
                              style: gameFont,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "0000",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "World",
                              style: gameFont,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "0-0",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Time",
                              style: gameFont,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "19:00",
                              style: gameFont,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    function: moveLeft,
                  ),
                  Button(
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    function: jump,
                  ),
                  Button(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
