import 'package:don_de_sang/Constants.dart';
import 'package:don_de_sang/Services/AuthServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Container(
            height: Constants.screenHeight * 0.08,
            width: double.infinity,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blueAccent,
                    )),
                SizedBox(
                  width: Constants.screenHeight * 0.05,
                ),
                Text(
                  "Mot de passe oublieé ",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: Constants.screenHeight * 0.03),
                )
              ],
            ),
          ),
          SizedBox(
            height: Constants.screenHeight * 0.3,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Saisir votre email ici ",
                    style: TextStyle(fontSize: Constants.screenHeight * 0.04),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " Champ obligatoire";
                        } else
                          return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ), // OutlineInputBorder
                        filled: true,
                        fillColor: Color(0xFFe7edeb),
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey[600],
                        ), //Icon
                      ), // InputDecoration
                    ),
                  ),
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.screenHeight * 0.05),
                        child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    AuthServices()
                                        .resetPassword(emailController.text)
                                        .then((value) {
                                      if (value) {
                                        Fluttertoast.showToast(
                                            backgroundColor: Colors.grey,
                                            msg:
                                                "consultez vos boite mail ", // message
                                            toastLength:
                                                Toast.LENGTH_SHORT, // length
                                            gravity:
                                                ToastGravity.BOTTOM, // location
                                            timeInSecForIosWeb: 1 // duration
                                            );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Fluttertoast.showToast(
                                            backgroundColor: Colors.grey,
                                            msg:
                                                "Aucune email trouvé", // message
                                            toastLength:
                                                Toast.LENGTH_SHORT, // length
                                            gravity:
                                                ToastGravity.BOTTOM, // location
                                            timeInSecForIosWeb: 1 // duration
                                            );
                                      }
                                    });
                                  }
                                },
                                child: Text("Recuperer"))),
                      )
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
