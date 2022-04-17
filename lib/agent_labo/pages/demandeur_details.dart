import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../Constants.dart';

var dataSnapshot = FirebaseFirestore.instance;

class DemandeurDetails extends StatefulWidget {
  final String idUser;
  const DemandeurDetails({Key? key, required this.idUser}) : super(key: key);

  @override
  _DonneurDetailsState createState() => _DonneurDetailsState();
}

class _DonneurDetailsState extends State<DemandeurDetails> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("List  de demands "),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: dataSnapshot
                        .collection("users")
                        .doc(widget.idUser)
                        .collection("demands")
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
                                  label = "Accepter ";
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
                                      height: Constants.screenHeight * 0.25,
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
                                                  "CIN : ${snapshotUserData.data!.docs[index].get("CIN")}"),
                                              Text(
                                                  "Quantité : ${snapshotUserData.data!.docs[index].get("quantity")}"),
                                              Text(
                                                  "Ville : ${snapshotUserData.data!.docs[index].get("ville")}"),
                                              Text("Etat: ${state}"),
                                              Text(
                                                  "Date de demande : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(snapshotUserData.data!.docs[index].get("creation_date").toDate())}"),
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
                                                            var stock = await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'stock')
                                                                .doc(snapshotUserData
                                                                    .data!
                                                                    .docs[index]
                                                                    .get(
                                                                        "TypeSang"))
                                                                .get();

                                                            if (stock[
                                                                    "quantité"] <
                                                                snapshotUserData
                                                                    .data!
                                                                    .docs[index]
                                                                    .get(
                                                                        "quantity")) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey,
                                                                      msg:
                                                                          "Quantité de stock est insuffisante", // message
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT, // length
                                                                      gravity:
                                                                          ToastGravity
                                                                              .BOTTOM, // location
                                                                      timeInSecForIosWeb:
                                                                          1 // duration
                                                                      );
                                                            } else {
                                                              snapshotUserData
                                                                  .data!
                                                                  .docs[index]
                                                                  .reference
                                                                  .update({
                                                                "State":
                                                                    "Terminé"
                                                              });
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "stock")
                                                                  .doc(snapshotUserData
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "TypeSang"))
                                                                  .update({
                                                                "quantité": stock[
                                                                        "quantité"] -
                                                                    snapshotUserData
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "quantity")
                                                              });
                                                            }
                                                          }
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
                          return Center(child: Text("Pas de demande encore"));
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
