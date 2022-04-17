import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Users.dart';
import 'DbServices.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
// creation d'instance de firebase auth
  //Authentification => instance firebaseAuth
  // base de donnée => instance firestore
  // stockage => instance  firestorage
  Future<bool> signIn(String Email, String Password) async {
    try {
      // try => jarreb el code hedha
      // await => yestana lin tekml el tache => order pour attendre la fin de tache
      // await ma t5dem kan m3a el async
      await auth.signInWithEmailAndPassword(email: Email, password: Password);
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(
    String CIN,
    String Nom,
    String Prenom,
    DateTime DateNais,
    String Ville,
    String Adresse,
    String LieuNaiss,
    String Sexe,
    String TypeSang,
    String Genre,
    String Email,
    String Tel,
    String Password,
    double Poids,
  ) async {
    try {
      //etape 1 : creation de compte
      await auth.createUserWithEmailAndPassword(
          email: Email, password: Password);

      //etape 2: enregistrement de l'utilisateur dans le firestore
      await DbServices().saveUser(Cusers(
        idUser: user!.uid,
        CIN: CIN,
        Nom: Nom,
        Prenom: Prenom,
        DateNais: DateNais,
        Ville: Ville,
        Adresse: Adresse,
        LieuNaiss: LieuNaiss,
        Sexe: Sexe,
        TypeSang: TypeSang,
        Genre: Genre,
        Email: Email,
        Tel: Tel,
        Poids: Poids,
      )); // à travers le formulaire
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  User? get user => auth.currentUser; //pour recuperer l'utilisateur courant
}
