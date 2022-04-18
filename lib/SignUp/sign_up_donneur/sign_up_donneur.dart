import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_de_sang/SignUp/components/alertTask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../Services/AuthServices.dart';

var UsersCollection = FirebaseFirestore.instance.collection("users");

class SignUpDonneur extends StatefulWidget {
  @override
  State<SignUpDonneur> createState() => _inscriptionState();
}

class _inscriptionState extends State<SignUpDonneur> {
  String sexe = "";
  final _formKey = GlobalKey<FormState>();
  String type_sange = "";
  bool check = false;
  bool isLoading = false;

  late DateTime DateNaiss = DateTime.now();
  TextEditingController CinController = TextEditingController();
  TextEditingController NomControlelr = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PrenomController = TextEditingController();
  TextEditingController TelController = TextEditingController();
  TextEditingController VilleController = TextEditingController();
  TextEditingController AdresseController = TextEditingController();
  TextEditingController LieuDeNaissanceController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController PoidsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Donneur'),
        elevation: 0,
        backgroundColor: Colors.red,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0.0),
              bottomLeft: Radius.circular(50.0),
            ),
          ),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: (20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Bienvenue!",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        buildTextFormField(
                            CinController, "Cin", TextInputType.text, false),

                        buildTextFormField(
                            NomControlelr, "Nom", TextInputType.text, false),
                        buildTextFormField(PrenomController, "Prenom",
                            TextInputType.text, false),
                        buildTextFormField(EmailController, "Email",
                            TextInputType.emailAddress, false),
                        buildTextFormField(PasswordController, "Mot de passe",
                            TextInputType.text, true),

                        buildTextFormField(TelController, "Numéro de Telephone",
                            TextInputType.phone, false),
                        buildTextFormField(PoidsController, "Poids",
                            TextInputType.number, false),
                        ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100))
                                  .then((value) {
                                setState(() {
                                  DateNaiss = value!;
                                  check = true;
                                });
                              });
                            },
                            child: check
                                ? Text(
                                    "Date de naissance  : ${DateFormat('yyyy-MM-dd').format(DateNaiss)}")
                                : Text("Date de naissance ")),
                        buildTextFormField(VilleController, "Ville",
                            TextInputType.text, false),
                        buildTextFormField(AdresseController, "Adresse",
                            TextInputType.text, false),
                        buildTextFormField(LieuDeNaissanceController,
                            "Lieu de Naiisance", TextInputType.text, false),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "Sexe:",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: "Féminin",
                                          groupValue: sexe,
                                          onChanged: (index) {
                                            {
                                              setState(() {
                                                sexe = "Féminin";
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text(' Féminin'),
                                      )
                                    ],
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: "Masculin",
                                          groupValue: sexe,
                                          onChanged: (index) {
                                            {
                                              setState(() {
                                                sexe = 'Masculin';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('Masculin'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        SizedBox(height: 20.0),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "Type de sang:",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'A+',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'A+';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('A+'),
                                      )
                                    ],
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'A-',
                                          groupValue: type_sange,
                                          onChanged: (index) {
                                            {
                                              setState(() {
                                                type_sange = "A-";
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('A-'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'B+',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'B+';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('B+'),
                                      )
                                    ],
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'B-',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'B-';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('B-'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'O+',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'O+';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('O+'),
                                      )
                                    ],
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'O-',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'O-';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('O-'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'AB+',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'AB+';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('AB+'),
                                      )
                                    ],
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: 'AB-',
                                          groupValue: type_sange,
                                          onChanged: (value) {
                                            {
                                              setState(() {
                                                type_sange = 'AB-';
                                              });
                                            }
                                            ;
                                          }),
                                      Expanded(
                                        child: Text('AB-'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        //SizedBox
                        //RaisedButton
                      ]) //container

                          ),
                    ),
                    isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (sexe.isEmpty) {
                                      Fluttertoast.showToast(
                                          backgroundColor: Colors.grey,
                                          msg: "Sexe est obligatore", // message
                                          toastLength:
                                              Toast.LENGTH_SHORT, // length
                                          gravity:
                                              ToastGravity.BOTTOM, // location
                                          timeInSecForIosWeb: 1 // duration
                                          );
                                    } else if (type_sange.isEmpty) {
                                      Fluttertoast.showToast(
                                          backgroundColor: Colors.grey,
                                          msg:
                                              "Type de sang est obligatoire", // message
                                          toastLength:
                                              Toast.LENGTH_SHORT, // length
                                          gravity:
                                              ToastGravity.BOTTOM, // location
                                          timeInSecForIosWeb: 1 // duration
                                          );
                                    } else if (!check) {
                                      Fluttertoast.showToast(
                                          backgroundColor: Colors.grey,
                                          msg:
                                              "Date de naissance est obligatoire", // message
                                          toastLength:
                                              Toast.LENGTH_SHORT, // length
                                          gravity:
                                              ToastGravity.BOTTOM, // location
                                          timeInSecForIosWeb: 1 // duration
                                          );
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      bool check = await AuthServices().signUp(
                                          CinController.text,
                                          NomControlelr.text,
                                          PrenomController.text,
                                          DateNaiss,
                                          VilleController.text,
                                          AdresseController.text,
                                          LieuDeNaissanceController.text,
                                          sexe,
                                          type_sange,
                                          "Donneur",
                                          EmailController.text,
                                          TelController.text,
                                          PasswordController.text,
                                          (double.parse(PoidsController.text)));
                                      if (check) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        alertTask(
                                          action: "Connecter",
                                          lottieFile: "images/success.json",
                                          message: "Compte creé avec success",
                                          press: () {
                                            Navigator.pushNamed(
                                                context, "/login");
                                          },
                                        ).show(context);
                                      } else {
                                        Fluttertoast.showToast(
                                            backgroundColor: Colors.grey,
                                            msg:
                                                "Email déja utilisé", // message
                                            toastLength:
                                                Toast.LENGTH_SHORT, // length
                                            gravity:
                                                ToastGravity.BOTTOM, // location
                                            timeInSecForIosWeb: 1 // duration
                                            );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  }
                                },

                                child: Text(
                                  "Enregister",
                                ), //TextStyle
                              ), //Text
                            ),
                          ),
                  ],
                ),
              ) //column
              )),
    );
  }

  Padding buildTextFormField(TextEditingController Controller, String label,
      TextInputType keyboardType, bool obscuretext) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: obscuretext,
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return "Champ obligatoire ";
          } else if (label == "Email" && !value.contains("@")) {
            return " format incorrecte d' email";
          }
        },
        controller: Controller,
        decoration: InputDecoration(
          label: Text("$label"),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
