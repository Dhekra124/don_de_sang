import 'package:don_de_sang/splash_screen.dart';
import 'package:flutter/material.dart';

import 'body.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DON_SANG',
     theme: ThemeData(
       colorScheme:ColorScheme.fromSwatch(primarySwatch: Colors.red),
     ),
     routes: {
        '/':(BuildContext context) => Body(),
     },
    );
  }
}

