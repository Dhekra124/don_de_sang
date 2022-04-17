import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

var dataSnapshot = FirebaseFirestore.instance;

class Stcock extends StatefulWidget {
  const Stcock({Key? key}) : super(key: key);

  @override
  _StcockState createState() => _StcockState();
}

class _StcockState extends State<Stcock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(
          "Stock",
          style: TextStyle(fontSize: Constants.screenHeight * 0.03),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: dataSnapshot.collection("stock").snapshots(),
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
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage('images/donator.png'),
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
                                                "Type de sang : ${snapshotUserData.data!.docs[index].reference.id}"),
                                            Text(
                                                "Quantité : ${snapshotUserData.data!.docs[index].get("quantité")}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        });
                  } else {
                    return Center(child: Text(""));
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
