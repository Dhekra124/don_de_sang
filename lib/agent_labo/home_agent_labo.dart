import 'dart:io';

import 'package:don_de_sang/Constants.dart';
import 'package:don_de_sang/agent_labo/pages/demandeurs.dart';
import 'package:don_de_sang/agent_labo/pages/donneurs.dart';
import 'package:don_de_sang/agent_labo/pages/stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../drawer/build_drawer.dart';

class HomePageAgentLabo extends StatefulWidget {
  const HomePageAgentLabo({Key? key}) : super(key: key);

  @override
  _HomePageDemandeurState createState() => _HomePageDemandeurState();
}

class _HomePageDemandeurState extends State<HomePageAgentLabo> {
  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  var user = GetStorage().read("user");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        label: "Donneur", icon: Icon(Icons.arrow_downward_outlined)),
    BottomNavigationBarItem(
        label: "Demandeur", icon: Icon(Icons.arrow_upward_outlined)),
    BottomNavigationBarItem(label: "Stock", icon: Icon(Icons.storage)),
  ];
  List Pages = [
    Donneurs(),
    Demandeurs(),
    Stcock(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: avoidReturnButton,
        child: Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  Icons.format_list_bulleted_sharp,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Constants.screenHeight * 0.01,
                    top: Constants.screenHeight * 0.03,
                    bottom: Constants.screenHeight * 0.1),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Bonjour ${user['Nom']} ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: Constants.screenHeight * 0.05),
                  ),
                ),
              ),
              Expanded(
                child: Pages[currentIndex],
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            items: items,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.orange,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
