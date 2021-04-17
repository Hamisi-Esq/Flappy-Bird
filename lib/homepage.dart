import 'dart:async';

import 'package:flappybirdclone/barriers.dart';
import 'package:flappybirdclone/bird.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  static double birdYaxis =0;
  double time = 0;
  double height =0;
  double initialheight = birdYaxis;
  bool gamehasStarted = false;

  void jump(){
    setState(() {
      time= 0;
      initialheight= birdYaxis;
    });

  }

  void startGame(){
    gamehasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight- height;
      });
      if(birdYaxis > 1){
        timer.cancel();
        gamehasStarted = false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      if(gamehasStarted){
                        jump();
                      }else{
                        startGame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0,birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gamehasStarted ? Text(" "): Text("T A P  T O  P L A Y",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(0,1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  )
                ],
              )
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SCORE",style: TextStyle(color: Colors.white,fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("0",style: TextStyle(color: Colors.white,fontSize: 35),)
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BEST",style: TextStyle(color: Colors.white,fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("10",style: TextStyle(color: Colors.white,fontSize: 35),)
                      ],
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
