import 'package:don_de_sang/splash_screen/splashScreen.dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'ForgotPassword/forgot_password.dart';
import 'Login/login_screen.dart';
import 'SignUp/sign_up_demandeur/sign_up_demandeur.dart';
import 'SignUp/sign_up_donneur/sign_up_donneur.dart';
import 'agent_labo/home_agent_labo.dart';
import 'demandeur/home_page_demandeur.dart';
import 'donneur/home_page_donneur.dart';

void main() async {
  await GetStorage.init(); //
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DON_SANG',
      routes: {
        '/': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/sign_up_donneur': (BuildContext context) => SignUpDonneur(),
        '/sign_up_demandeur': (BuildContext context) => SignUpDemandeur(),
        '/home_demandeur': (BuildContext context) => HomePageDemandeur(),
        '/home_donneur': (BuildContext context) => HomePageDonneur(),
        '/home_agent': (BuildContext context) => HomePageAgentLabo(),
        '/forgot_password': (BuildContext context) => ForgotPassword(),
      },
    );
  }
}
