import 'package:don_de_sang/DemandeSang.dart';
import 'package:don_de_sang/inscription.dart';
import 'package:flutter/material.dart';

class choix extends  StatefulWidget{
  @override
  State<choix> createState() =>_choix();
  }
  class _choix extends State<choix>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Application du don de sang'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            // ignore: unnecessary_new
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(height: 50,),
                new Text("Vous pouvez choisir votre choix !",
                  style:TextStyle(
                    color: Colors.black,
                    fontSize:22.0,
                    fontWeight: FontWeight.w800,),),
            MyImage3(),



                SizedBox(height: 20,),
                ElevatedButton (child: Text("Donneur"), onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>inscription()),
                  );
                }

                ),
                SizedBox(height: 30,),

                ElevatedButton (child:Text("Demandeur"),onPressed:(){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DemandeSang()),
                  );
                }),








              ],

            ),


          ),
        ],
      ),
    );
  }
  }
  class MyImage3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage image = new AssetImage('images/image3.jpg');
    Image myImg = new Image(image: image,height: 250,width: 250,);
    return Container(
      child: myImg,

    ) ;
  }

  }

