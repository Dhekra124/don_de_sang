import 'package:don_de_sang/splash_screen.dart';
import 'package:don_de_sang/validation.dart';
import 'package:flutter/material.dart';

class inscription extends StatefulWidget{
  @override
  State<inscription> createState() => _inscriptionState();
}
class _inscriptionState extends State<inscription> {
  int _value=1;
  int _value1=1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Application de don du sang'),
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
                         new Text("Welcome!",
                             style:TextStyle(
                               color: Colors.black,
                               fontSize:20.0,
                               fontWeight: FontWeight.w800,),
                         ),

                         SizedBox(height: 20.0),
                  TextField(
                    decoration:InputDecoration(
                      labelText:'CIN',
                    hintText:"CIN",
                    border:const OutlineInputBorder(),
                  ),
            ),
                  SizedBox(height: 20.0),
                 TextField(
                 decoration:InputDecoration(
                  labelText:'Nom',
                  hintText:"Nom",
                   border:const OutlineInputBorder(),


      ),
    ),
                  SizedBox(height: 20.0),

    TextField(
    decoration:InputDecoration(
    labelText:'Prenom',
    hintText:"Prenom",
    border:const OutlineInputBorder(),
    ),
    ),
    SizedBox(height: 20.0),

    TextField(
    decoration:InputDecoration(
    labelText:'Numéro de Telephone',
    hintText:"Numéro de Telephone",
    border:const OutlineInputBorder(),
    ),
    ),
                  SizedBox(height: 20.0),

    TextField(
    decoration:InputDecoration(
    labelText:'Date de Naissance',
    hintText:"Date de Naissance",
    border:const OutlineInputBorder(),
    ),
    ),
                         SizedBox(height: 20.0),

                         TextField(
                           decoration:InputDecoration(
                             labelText:'Ville',
                             hintText:"Ville",
                             border:const OutlineInputBorder(),
                           ),
                         ),
                  SizedBox(height: 20.0),

                  TextField(
                  decoration:InputDecoration(
    labelText:'Adresse',
    hintText:"Adresse",
    border:const OutlineInputBorder(),
    ),
    ),
                  SizedBox(height: 20.0),

    TextField(

    decoration:InputDecoration(
      labelText:'Lieu de Naissance',
    hintText:"Lieu de Naissance",
      border:const OutlineInputBorder(),


    ),
    ),
SizedBox(height: 10.0),
                       new Text("Sexe:",textAlign: TextAlign.left,),
                         Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Radio(value: 1, groupValue: _value1, onChanged: (index){
                                         {
                                           setState(() {
                                             _value1= 1;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('F'),
                                       )
                                     ],

                                   ),
                                   flex: 1,
                                 ),
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Radio(value: 2, groupValue: _value1, onChanged: (index){
                                         {
                                           setState(() {
                                             _value1= 2;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('M'),
                                       )
                                     ],

                                   ),
                                 )
                               ],
                             )
                           ],
                         ),






    SizedBox(height: 20.0),


      TextField(
        decoration:InputDecoration(
          labelText:'Combien de nombres de fois ',
          hintText:"nombres de fois donner",
          border:const OutlineInputBorder(),
        ),
      ),
                         SizedBox(height: 20.0),


   new Text("Type de sang:",textAlign: TextAlign.left,),
    SizedBox(width: 10.0),
                         Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 Expanded(
                                     child: Row(
                                       children: [
                                         Radio(value: 3, groupValue: _value, onChanged: (value){
                                           {
                                             setState(() {
                                               _value= 3;
                                             });
                                           };
                                         }),
                                         Expanded(child:
                                         Text('A+'),
                                         )
                                       ],

                                     ),
                                   flex: 1,
                     ),
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Radio(value: 4, groupValue: _value, onChanged: (index){
                                         {
                                           setState(() {
                                             _value= 4;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('A-'),
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
                                       Radio(value: 5, groupValue: _value, onChanged: (value){
                                         {
                                           setState(() {
                                             _value= 5;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('B+'),
                                       )
                                     ],

                                   ),
                                   flex: 1,
                                 ),
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Radio(value: 6, groupValue: _value, onChanged: (value){
                                         {
                                           setState(() {
                                             _value= 6;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('B-'),
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
                                       Radio(value: 7, groupValue: _value, onChanged: (value){
                                         {
                                           setState(() {
                                             _value= 7;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('O+'),
                                       )
                                     ],

                                   ),
                                   flex: 1,
                                 ),
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Radio(value: 8, groupValue: _value, onChanged: (value){
                                         {
                                           setState(() {
                                             _value= 8;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('O-'),
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
                                       Radio(value: 9, groupValue: _value, onChanged: (value){
                                         {
                                           setState(() {
                                             _value= 9;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('AB+'),
                                       )
                                     ],

                                   ),
                                   flex: 1,
                                 ),
                                 Expanded(
                                   child: Row(
                                     children: [
                                       Radio(value: 10, groupValue: _value, onChanged: (value){
                                         {
                                           setState(() {
                                             _value= 10;
                                           });
                                         };
                                       }),
                                       Expanded(child:
                                       Text('AB-'),
                                       )
                                     ],

                                   ),
                                 )
                               ],
                             )
                           ],
                         ),









    SizedBox(
        height: 50.0
    ),//SizedBox
    Container(
      width:double.infinity,
      child:RaisedButton(
        onPressed: (){

          Navigator.push(
            context, MaterialPageRoute(builder: (context) => validation()),
          );

        },
        color: Colors.red,
        child: Text(
          "Enregister",
        ),//TextStyle
      ),//Text
    ),//RaisedButton
    ]
    ) //container





                  )//column
    )





                 ),

               );
  }
}













