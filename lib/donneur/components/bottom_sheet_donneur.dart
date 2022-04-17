import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

var user = GetStorage().read("user");
var donCollection = FirebaseFirestore.instance
    .collection("users")
    .doc("${user['idUser']}")
    .collection("dons");

bottomSheet(BuildContext context) {
  DateTime dateDon = DateTime.now();
  bool check = false;
  bool isLoading = false;
  bool isDone = false;
  Size size = MediaQuery.of(context).size;
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            color: Colors.transparent,
            child: Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                  color: Color(0xffe3eaef),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07, vertical: 50),
                child: isDone
                    ? doneAddPlanning(context, size)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Ajouter un  de demande de don  "),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: size.width * 0.08,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100))
                                        .then((value) {
                                      setState(() {
                                        dateDon = value!;
                                        check = true;
                                      });
                                    });
                                  },
                                  child: check
                                      ? Text(
                                          "Date de don  : ${DateFormat('yyyy-MM-dd').format(dateDon)}")
                                      : Row(
                                          children: [
                                            Icon(Icons.add),
                                            Text("Date de don "),
                                          ],
                                        )),
                            ],
                          ),
                          isLoading
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: EdgeInsets.all(15),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text("Annuler"),
                                        )),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: EdgeInsets.all(15),
                                        ),
                                        onPressed: () async {
                                          if (check &&
                                              DateTime.now()
                                                  .isBefore(dateDon)) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await donCollection.add({
                                              'date': dateDon,
                                              'idUser': user['idUser'],
                                              'Tel': user['Tel'],
                                              'TypeSang': user['TypeSang'],
                                              'Nom': user['Nom'],
                                              'Prenom': user['Prenom'],
                                              'CIN': user['CIN'],
                                              'State': "En attente",
                                              'creation_date': DateTime.now()
                                            });
                                            setState(() {
                                              isLoading = false;
                                              isDone = true;
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.grey,
                                                msg:
                                                    "Selectionnez une date au future", // message
                                                toastLength: Toast
                                                    .LENGTH_SHORT, // length
                                                gravity: ToastGravity
                                                    .BOTTOM, // location
                                                timeInSecForIosWeb:
                                                    1 // duration
                                                );
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        },
                                        child: Text("Confirmer")),
                                  ],
                                ),
                        ],
                      ),
              ),
            ),
          );
        });
      });
}

Column doneAddPlanning(BuildContext context, Size size) {
  return Column(
    children: [
      Lottie.asset("images/success.json",
          height: size.height * 0.1, repeat: false),
      Text(
        "Votre don à été ajouté avec succès",
        style: TextStyle(fontSize: size.height * 0.02),
      ),
      SizedBox(
        height: size.height * 0.08,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(15),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Sortir"),
          ))
    ],
  );
}
