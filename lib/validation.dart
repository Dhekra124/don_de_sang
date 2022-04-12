import 'package:don_de_sang/splash_screen.dart';
import 'package:flutter/material.dart';


class validation extends StatefulWidget{
  @override
  State<validation> createState() => _validationState();
}

class _validationState extends State<validation> {
      @override
      Widget build(BuildContext context) {
      return Scaffold(

            backgroundColor: Colors.white,
            appBar: AppBar(
                  title: Text('Application  don du sang'),
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
            body:

            SizedBox(
                  width: double.infinity,
                  child:Padding(
                      padding:
                      EdgeInsets.symmetric(
                          horizontal: (20)),

                      child:SingleChildScrollView(
                          child:Column(
                                children:[

                                      SizedBox(height:20,
                                      ),
                                      TextField(
                                            decoration:InputDecoration(
                                                  labelText:'Id ',
                                                  hintText:"Id ",
                                                  border:const OutlineInputBorder(),
                                            ),
                                      ),
                                      SizedBox(height: 20.0),
                                      TextField(
                                            decoration:InputDecoration(
                                                  labelText:'Qauntité',
                                                  hintText:"Qauntité",
                                                  border:const OutlineInputBorder(),


                                            ),
                                      ),
                                      SizedBox(height: 20.0),

                                      TextField(
                                            decoration:InputDecoration(
                                                  labelText:'Lieu',
                                                  hintText:"Lieu",
                                                  border:const OutlineInputBorder(),
                                            ),
                                      ),
                                      SizedBox(height: 20.0),

                                      TextField(
                                            decoration:InputDecoration(
                                                  labelText:'Date',
                                                  hintText:"Date",
                                                  border:const OutlineInputBorder(),
                                            ),
                                      ),


                                      SizedBox(
                                          height: 50.0
                                      ),//SizedBox
                                      Container(
                                            width:double.infinity,
                                            child:RaisedButton(
                                                  onPressed: (){},
                                                  color: Colors.red,
                                                  child: Text(
                                                        "Valider",
                                                  ),//TextStyle
                                            ),//Text
                                      ),//RaisedButton
                                ]
                          ) //container





                                ,//children
                          )//column
                      )





                  ),
            );





      }
      }
