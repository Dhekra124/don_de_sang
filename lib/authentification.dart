

import 'package:don_de_sang/choix.dart';
import 'package:don_de_sang/inscription.dart';
import 'package:don_de_sang/splash_screen.dart';

import 'package:flutter/material.dart';
class authentification extends StatefulWidget{
  @override
  State<authentification> createState() => _authentificationState();
}

class _authentificationState extends State<authentification> {

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application de don du sang'),
        backgroundColor: Colors.red,
      ),

      body:SingleChildScrollView(
        child:Container(
          constraints:BoxConstraints(
            maxHeight:MediaQuery.of(context).size.height,
            minWidth:MediaQuery.of(context).size.height,
          ), //BoxConstraints
          decoration:BoxDecoration(
            gradient:LinearGradient(
                colors:[
                  Colors.white,
              Colors.white,
              ],

              begin: Alignment.topLeft,
              end: Alignment.centerRight,

            ),//LinearGradient
          ),//BoxDecoration

          child:Column(
            children: [
              Expanded(
                flex:2,
                child:Padding(
                  // ignore: const_constructor_field_type_mismatch
                  padding: const EdgeInsets.symmetric(
                      vertical:  36.0,horizontal :24.0
                  ),//EdgeInsets.symmetric


                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyImage2(),
                      Text(
                        "Connexion",
                        style:TextStyle(

                          color: Colors.black,
                          fontSize:46.0,
                          fontWeight: FontWeight.w800,


                        ),//TextStyle
                      ), //Text


                    ],
                  ),//Column
                ),//Padding
              ),//Expanded
              SizedBox(height:40),

              Expanded(
                child:Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(40),
                      topRight:Radius.circular(40),

                    ),//BorderRadius.only
                  ),// BoxDecoration
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    TextField(
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),// OutlineInputBorder
                      filled: true,
                      fillColor: Color(0xFFe7edeb),
                      hintText: "E-mail",
                      prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey[600],
                    ),//Icon
                  ),// InputDecoration
                ),//TextField

                ]
                ),),
    ),
              SizedBox(height:20),
                TextField(
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),// OutlineInputBorder
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: "Password",
                    prefixIcon: Icon(
                    Icons.password,
                    color: Colors.grey[600],
                  ),//Icon
                ),// InputDecoration
              ),//TextField



        //Padding
      //Container
    //Expanded
    SizedBox(
    height: 50.0
    ),//SizedBox
    Container(
    width:double.infinity,
    child:RaisedButton(
    onPressed: (){

        Navigator.push(
          context, MaterialPageRoute(builder: (context) => choix()),
        );

    },
    color: Colors.red[800],
    child: Text(
    "Connexion",
    ),//TextStyle
    ),//Text
    ),//RaisedButton
            ]
    ) //container

      ),//Container
    ),

    );//Scaffold



  }


}
class MyImage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage image = new AssetImage('images/image2.png');
    Image myImg = new Image(image: image,);
    return Container(
      child: myImg,

    ) ;

  }

}
