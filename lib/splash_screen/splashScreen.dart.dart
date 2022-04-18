import 'dart:async';

import 'package:don_de_sang/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Login/login_screen.dart';
import '../agent_labo/home_agent_labo.dart';
import '../demandeur/home_page_demandeur.dart';
import '../donneur/home_page_donneur.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<SplashScreen> {
  @override
  void initState() {
    var auth = GetStorage().read("auth");

    var type_auth = GetStorage().read("type_auth");
    Timer(
      Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          if (auth == 1) {
            if (type_auth == 1) {
              return HomePageAgentLabo();
            } else if (type_auth == 2) {
              return HomePageDonneur();
            } else {
              return HomePageDemandeur();
            }
          } else {
            return LoginScreen();
          }
        }),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: Constants.screenHeight * 0.3,
                  child: Image.asset("images/image.jpg")),
              Container(
                  height: Constants.screenHeight * 0.3,
                  child: Image.asset("images/drapo.png")),
              new Text(
                "SANG DONNE ",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              new Text(
                "= ",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              new Text(
                "VIE SAUVÉE ",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
