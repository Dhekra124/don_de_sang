import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Constants.dart';
import '../alertLogOut.dart';

Drawer buildDrawer(BuildContext context) {
  var user = GetStorage().read("user");
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade300,
              Colors.blueGrey,
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: Constants.screenHeight * 0.07,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("images/user.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nom: ${user['Nom']}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Prénom: ${user['Prenom']}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "CIN: ${user['CIN']}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Type de sang: ${user['TypeSang']}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.screenHeight * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    alertLogOut(
                      press: () {
                        Navigator.pop(context);
                      },
                    ).show(context);
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Déconnecter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
