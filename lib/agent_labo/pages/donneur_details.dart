import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../Constants.dart';

var dataSnapshot = FirebaseFirestore.instance;

class DonneurDetails extends StatefulWidget {
  final String idUser;
  const DonneurDetails({Key? key, required this.idUser}) : super(key: key);

  @override
  _DonneurDetailsState createState() => _DonneurDetailsState();
}

class _DonneurDetailsState extends State<DonneurDetails> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("List  de dons "),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: dataSnapshot
                        .collection("users")
                        .doc(widget.idUser)
                        .collection("dons")
                        .snapshots(),
                    builder: (context, snapshotUserData) {
                      if (snapshotUserData.hasData) {
                        if (snapshotUserData.data!.size != 0) {
                          return ListView.builder(
                              itemCount: snapshotUserData.data!.size,
                              itemBuilder: (context, index) {
                                Color stateColor = Colors.transparent;
                                String label = "";
                                String state = snapshotUserData
                                    .data!.docs[index]
                                    .get('State');
                                if (state == "En attente") {
                                  label = "Accepter date";
                                  stateColor =
                                      Colors.blueAccent.withOpacity(0.5);
                                } else if (state == "En cours") {
                                  stateColor = Colors.orange.withOpacity(0.5);
                                  label = "Terminer";
                                } else {
                                  stateColor = Colors.green.withOpacity(0.5);
                                  label = "Terminé";
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: Constants.screenHeight * 0.20,
                                      decoration: BoxDecoration(
                                          color: stateColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Date de don : ${DateFormat('yyyy-MM-dd').format(snapshotUserData.data!.docs[index].get("date").toDate())}"),
                                              Text(
                                                  "CIN : ${snapshotUserData.data!.docs[index].get("CIN")}"),
                                              Text("Etat: ${state}"),
                                              Text(
                                                  "Date de don : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(snapshotUserData.data!.docs[index].get("creation_date").toDate())}"),
                                              Spacer(),
                                              ElevatedButton(
                                                  onPressed: label != "Terminé"
                                                      ? () async {
                                                          if (state ==
                                                              "En attente") {
                                                            snapshotUserData
                                                                .data!
                                                                .docs[index]
                                                                .reference
                                                                .update({
                                                              "State":
                                                                  "En cours"
                                                            });
                                                          } else if (state ==
                                                              "En cours") {
                                                            snapshotUserData
                                                                .data!
                                                                .docs[index]
                                                                .reference
                                                                .update({
                                                              "State": "Terminé"
                                                            });

                                                            var stock =
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'stock')
                                                                    .doc(user[
                                                                        'TypeSang'])
                                                                    .get();

                                                            var addBloodToType =
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "stock")
                                                                    .doc(user[
                                                                        'TypeSang'])
                                                                    .update({
                                                              "quantité": stock[
                                                                      "quantité"] +
                                                                  1
                                                            });
                                                          } else {}
                                                        }
                                                      : null,
                                                  child: Text("$label"))
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
          )),
    );
  }
}
