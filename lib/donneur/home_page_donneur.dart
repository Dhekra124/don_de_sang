import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_de_sang/Constants.dart';
import 'package:don_de_sang/donneur/components/bottom_sheet_donneur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../drawer/build_drawer.dart';

var dataSnapshot = FirebaseFirestore.instance;

class HomePageDonneur extends StatefulWidget {
  const HomePageDonneur({Key? key}) : super(key: key);

  @override
  _HomePageDemandeurState createState() => _HomePageDemandeurState();
}

class _HomePageDemandeurState extends State<HomePageDonneur> {
  var user = GetStorage().read("user");
  bool nodata = true;
  late int snapshotSize;

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
              Padding(
                padding: EdgeInsets.only(
                    left: Constants.screenHeight * 0.01,
                    top: Constants.screenHeight * 0.01),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Mes dons ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: Constants.screenHeight * 0.03),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: dataSnapshot
                        .collection("users")
                        .doc("${user['idUser']}")
                        .collection("dons")
                        .snapshots(),
                    builder: (context, snapshotUserData) {
                      if (snapshotUserData.hasData) {
                        if (snapshotUserData.data!.size != 0) {
                          return ListView.builder(
                              itemCount: snapshotUserData.data!.size,
                              itemBuilder: (context, index) {
                                Color stateColor = Colors.transparent;
                                String state = snapshotUserData
                                    .data!.docs[index]
                                    .get('State');
                                if (state == "En attente") {
                                  stateColor =
                                      Colors.blueAccent.withOpacity(0.5);
                                } else if (state == "En cours") {
                                  stateColor = Colors.orange.withOpacity(0.5);
                                } else {
                                  stateColor = Colors.green.withOpacity(0.5);
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: Constants.screenHeight * 0.13,
                                      decoration: BoxDecoration(
                                          color: stateColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Date de don  : ${DateFormat('yyyy-MM-dd').format(snapshotUserData.data!.docs[index].get("date").toDate())}"),
                                              Text(
                                                  "Etat de demande de don : ${state}"),
                                              Text(
                                                  "Date de création : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(snapshotUserData.data!.docs[index].get("creation_date").toDate())}"),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              });
                        } else {
                          return Center(child: Text("Pas de dons encore"));
                        }
                      } else {
                        return Center(child: Text(""));
                      }
                    }),
              ),
            ],
          ),
          floatingActionButton: StreamBuilder<QuerySnapshot>(
              stream: dataSnapshot
                  .collection("users")
                  .doc("${user['idUser']}")
                  .collection("dons")
                  .snapshots(),
              builder: (context, snapshotUserData) {
                if (snapshotUserData.hasData) {
                  if (snapshotUserData.data!.size != 0) {
                    Duration diff = DateTime.now().difference(
                        snapshotUserData.data!.docs.first.get("date").toDate());
                    if (diff.inDays > 90) {
                      return FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          bottomSheet(context);
                        },
                      );
                    } else {
                      return FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          Fluttertoast.showToast(
                              backgroundColor: Colors.grey,
                              msg:
                                  "vous aves pas le droit de donner un don pour le moment", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.BOTTOM, // location
                              timeInSecForIosWeb: 1 // duration
                              );
                        },
                      );
                    }
                  } else {
                    return FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        bottomSheet(context);
                      },
                    );
                  }
                } else {
                  return Center(child: Text(""));
                }
              }),
        ),
      ),
    );
  }
}
