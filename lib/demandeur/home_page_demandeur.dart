import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_de_sang/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../alertLogOut.dart';
import 'components/bottom_sheet_demandeur.dart';

var dataSnapshot = FirebaseFirestore.instance;

class HomePageDemandeur extends StatefulWidget {
  const HomePageDemandeur({Key? key}) : super(key: key);

  @override
  _HomePageDemandeurState createState() => _HomePageDemandeurState();
}

class _HomePageDemandeurState extends State<HomePageDemandeur> {
  var user = GetStorage().read("user");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: buildDrawer(),
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
                  "Bonjour User ",
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
                  "Mes demands  ",
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
                      .collection("demands")
                      .snapshots(),
                  builder: (context, snapshotUserData) {
                    if (snapshotUserData.hasData) {
                      if (snapshotUserData.data!.size != 0) {
                        return ListView.builder(
                            itemCount: snapshotUserData.data!.size,
                            itemBuilder: (context, index) {
                              Color stateColor = Colors.transparent;
                              String state = snapshotUserData.data!.docs[index]
                                  .get('State');
                              if (state == "En attente") {
                                stateColor = Colors.blueAccent.withOpacity(0.5);
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
                                                "Etat de demande de don : ${state}"),
                                            Text(
                                                "Quantité de sang : ${snapshotUserData.data!.docs[index].get("quantity")}"),
                                            Text(
                                                "Date de demande : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(snapshotUserData.data!.docs[index].get("creation_date").toDate())}"),
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var instance = await FirebaseFirestore.instance
                .collection('users')
                .doc(user['idUser'])
                .collection("demands")
                .get()
                .then((value) => (value.size));
            if (instance >= 3) {
              Fluttertoast.showToast(
                  backgroundColor: Colors.grey,
                  msg: "vous avez pas le droit ", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.BOTTOM, // location
                  timeInSecForIosWeb: 1 // duration
                  );
            } else {
              bottomSheetDemandeur(context);
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigo.shade300,
                Colors.blueGrey,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: Constants.screenHeight * 0.07,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("images/user.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nom: ${user['Nom']}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Prénom: ${user['Prenom']}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "CIN: ${user['CIN']}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Type de sang: ${user['TypeSang']}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Constants.screenHeight * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      alertLogOut(
                        press: () {
                          Navigator.pop(context);
                        },
                      ).show(context);
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Déconnecter",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
