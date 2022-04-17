import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_de_sang/agent_labo/pages/demandeur_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../Constants.dart';

var dataSnapshot = FirebaseFirestore.instance;

class Demandeurs extends StatefulWidget {
  const Demandeurs({Key? key}) : super(key: key);

  @override
  _StcockState createState() => _StcockState();
}

class _StcockState extends State<Demandeurs> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(
          "List  de demandeurs",
          style: TextStyle(fontSize: Constants.screenHeight * 0.03),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: dataSnapshot
                  .collection("users")
                  .where("Genre", isEqualTo: "Demandeur")
                  .snapshots(),
              builder: (context, snapshotUserData) {
                if (snapshotUserData.hasData) {
                  if (snapshotUserData.data!.size != 0) {
                    return ListView.builder(
                        itemCount: snapshotUserData.data!.size,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: Constants.screenHeight * 0.13,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {
                                    Get.to(DemandeurDetails(
                                      idUser: snapshotUserData.data!.docs[index]
                                          .get("idUser"),
                                    ));
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage('images/user.png'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: Constants.screenWidth * 0.07,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Nom: ${snapshotUserData.data!.docs[index].get('Nom')}"),
                                            Text(
                                                "Prenom: ${snapshotUserData.data!.docs[index].get('Prenom')}"),
                                            Text(
                                                "CIN: ${snapshotUserData.data!.docs[index].get('CIN')}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        });
                  } else {
                    return Center(child: Text("Pas de demandeurs encore"));
                  }
                } else {
                  return Center(child: Text(""));
                }
              }),
        )
      ],
    ));
  }
}