import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RememberController extends GetxController {
  RememberAgent(Map user) {
    var storage = GetStorage();
    token(1);
    storage.write("user", {
      'Email': user['Email'],
      'Prenom': user['Prenom'],
      'Nom': user['Nom'],
      'Tel': user['Tel'],
      'TypeSang': user['TypeSang'],
      'idUser': user['idUser'],
      'CIN': user['CIN'],
      'Ville': user['Ville'],
    });
  }

  RememberDemandeur(Map user) {
    var storage = GetStorage();
    token(3);
    storage.write("user", {
      'Email': user['Email'],
      'Prenom': user['Prenom'],
      'Nom': user['Nom'],
      'Tel': user['Tel'],
      'TypeSang': user['TypeSang'],
      'idUser': user['idUser'],
      'CIN': user['CIN'],
      'Ville': user['Ville'],
    });
  }

  RememberDonneur(Map user) {
    var storage = GetStorage();
    token(2);
    storage.write("user", {
      'Email': user['Email'],
      'Prenom': user['Prenom'],
      'Nom': user['Nom'],
      'Tel': user['Tel'],
      'TypeSang': user['TypeSang'],
      'idUser': user['idUser'],
      'CIN': user['CIN'],
      'Ville': user['Ville'],
    });
  }

  token(int index) {
    var storage = GetStorage();
    storage.write("auth", 1); // fama chkon 3mal login :)
    storage.write("type_auth", index);
  }

  Logout() async {
    var storage = GetStorage();
    storage.write("auth", 0);
  }
}
