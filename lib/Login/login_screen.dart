import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_de_sang/Constants.dart';
import 'package:don_de_sang/Login/remember_controller.dart';
import 'package:don_de_sang/Services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../SignUp/components/alertTask.dart';
import '../SignUp/components/alert_choose_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  RememberController controller = RememberController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordControlelr = TextEditingController();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: avoidReturnButton,
        child: SingleChildScrollView(
          child: Column(children: [
            Lottie.asset("images/login.json"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: EmailController,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ), // OutlineInputBorder
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey[600],
                  ), //Icon
                ), // InputDecoration
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                controller: PasswordControlelr,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ), // OutlineInputBorder
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: "Mot de passe",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey[600],
                  ), //Icon
                ), // InputDecoration
              ),
            ),
            isLoading
                ? CircularProgressIndicator()
                : Container(
                    width: size.width * 0.9,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          Future check = AuthServices().signIn(
                              EmailController.text, PasswordControlelr.text);

                          check.then((value) async {
                            if (value) {
                              final FirebaseAuth auth =
                                  await FirebaseAuth.instance;
                              final User? user = await auth.currentUser;
                              final uid = user!.uid;
                              var UserData = await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .get();

                              if (UserData["Genre"] == "Agent") {
                                // test de role
                                await controller.RememberAgent(UserData.data()
                                    as Map<String,
                                        dynamic>); //.data() pour recuperer le donneées de document
                                Navigator.pushNamed(context, '/home_agent');
                              } else if (UserData["Genre"] == "Donneur") {
                                await controller.RememberDonneur(UserData.data()
                                    as Map<String,
                                        dynamic>); //.data() pour recuperer le donneées de document
                                Navigator.pushNamed(context, '/home_donneur');
                              } else if (UserData["Genre"] == "Demandeur") {
                                await controller.RememberDemandeur(
                                    UserData.data() as Map<String,
                                        dynamic>); //.data() pour recuperer le donneées de document
                                Navigator.pushNamed(context, '/home_demandeur');
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              alertTask(
                                lottieFile: "images/error.json",
                                action: "Ressayer",
                                message: "pas de compte avec ces cordonnées ",
                                press: () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context);
                                },
                              ).show(context);
                            }
                          });
                        },
                        child: Text("Connecter"))),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgot_password");
                        },
                        child: Text(
                          "Mot de pass oublieé ?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Constants.screenHeight * 0.25,
            ),
            Container(
                child: TextButton(
              onPressed: () {
                alertChooseType().show(context);
              },
              child: Text("Créer un compte"),
            ))
            //TextField
          ]), //Container
        ),
      ),
    ); //Scaffold
  }
}
