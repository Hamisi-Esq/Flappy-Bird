import 'dart:async';

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
              child: GestureDetector(
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
              )
          ),
          Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  children: [
                    Column()
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
