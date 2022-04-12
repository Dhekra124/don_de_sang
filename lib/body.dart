import 'package:don_de_sang/authentification.dart';
import 'package:flutter/material.dart';
class Body extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Application  don du sang'),
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



                MyImage1(),


                    MyImage(),


                    new Text("SANG DONNE ",
                      style:TextStyle(
                        color: Colors.green,
                        fontSize:30.0,
                        fontWeight: FontWeight.w800,),

                    ),
                    SizedBox(height: 20,),


                      new Text("= ",
                        style:TextStyle(
                          color: Colors.green,
                          fontSize:30.0,
                          fontWeight: FontWeight.w800,),
                      ),
                        SizedBox(height: 10,),



                        new Text("VIE SAUVÉE ",
                          style:TextStyle(
                            color: Colors.green,
                            fontSize:30.0,
                            fontWeight: FontWeight.w800,),






),


                    SizedBox(height: 30.0),


                    ElevatedButton (child: Text("Entrer"), onPressed:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>authentification()),
                        );
                      }
                      ),
                    SizedBox(width: 50,),
                    ElevatedButton (child:Text("Quitter"),onPressed:(){;
                    }),








                  ],


              ),


    ),

    ],

    ),

    );
  }
}
class MyImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage image = new AssetImage('images/drapo.png');
    Image myImg = new Image(image: image,width: 80,height: 80);
    return Container(
      child: myImg,

    ) ;
  }

}
class MyImage1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage image = new AssetImage('images/image.jpg');
    Image myImg = new Image(image: image,width: 200,height: 200,)
    ;
    return Container(
      child: myImg,

    ) ;

  }

}





