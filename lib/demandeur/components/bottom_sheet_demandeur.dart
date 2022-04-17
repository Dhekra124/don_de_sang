import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

var user = GetStorage().read("user");
var demandeCollection = FirebaseFirestore.instance
    .collection("users")
    .doc("${user['idUser']}")
    .collection("demands");

bottomSheetDemandeur(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  TextEditingController QuantityController = TextEditingController();

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
              height: size.height * 0.7,
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
                          Text("Ajouter un  de demande   "),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "champ obligatoire";
                                  }
                                },
                                controller: QuantityController,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ), // OutlineInputBorder
                                  filled: true,
                                  fillColor: Color(0xFFe7edeb),
                                  hintText: "Quantité en Litre",
                                  prefixIcon: Icon(
                                    Icons.format_list_numbered_sharp,
                                    color: Colors.grey[600],
                                  ), //Icon
                                ), // InputDecoration
                              ),
                            ),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await demandeCollection.add({
                                              'idUser': user['idUser'],
                                              'Tel': user['Tel'],
                                              'TypeSang': user['TypeSang'],
                                              'Nom': user['Nom'],
                                              'Prenom': user['Prenom'],
                                              'CIN': user['CIN'],
                                              'State': "En attente",
                                              'quantity': int.parse(
                                                  QuantityController.text),
                                              'creation_date': DateTime.now(),
                                              'ville': user['Ville']
                                            });
                                            setState(() {
                                              isLoading = false;
                                              isDone = true;
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
        "Votre demande est en attente ",
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
