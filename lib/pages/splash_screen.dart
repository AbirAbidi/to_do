import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), ()=> Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>HomePage())));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color:Color.fromARGB(167, 83, 83, 83),
          child: Center(child: Text("Abiro Lista",style: TextStyle(color: Colors.black,fontSize: 50),)),
        ),
      ),
    );
  }
}