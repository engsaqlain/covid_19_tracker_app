import 'dart:async';

import 'package:covid_19_tracker_app/view/world_states_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _animationController = AnimationController(
      duration:  Duration(seconds: 3),
      vsync: this)..repeat();
void dispose(){
  super.dispose();
  _animationController.dispose();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
    () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStatesScreen(),));
    },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               AnimatedBuilder(
                   animation: _animationController,
                   child: Container(
                     height: 200,
                     width: 200,
                     child: Center(child:  Image.asset('images/virus.png')),),

                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                        angle: _animationController.value * 2.0 * math.pi,
                    child: child,);
                  }



               ),
              SizedBox(height:  MediaQuery.of(context).size.height *0.08),
              Align(
                alignment: Alignment.center,
                child: Text('Covid-19\n Tracker- App', textAlign: TextAlign.center, style: TextStyle(
                  fontWeight:  FontWeight.bold,
                  fontSize: 25,

                  
                ),),
              ),
              
            ],
          )),
    );
  }
}
